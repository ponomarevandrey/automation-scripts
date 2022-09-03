//
// Replace Windows links (.lnk) with Linux symlinks
// 

const path = require("path");
const fs = require("fs-extra");

const LNK_LOCATION = process.argv[2];
const ORIGINALS_LOCATION =  process.argv[3];

function isLnk(nodePath) {
  return path.extname(nodePath) === ".lnk";
}

function isName(filename) {
  return function(nodePath) {
    return filename === path.parse(nodePath).base;    
  }
}

async function findFiles(dirPath, arrayOfFiles, findFilesCallback) {
  const fileSystemNodes = await fs.readdir(dirPath);

  for (let fileSystemNode of fileSystemNodes) {
    const nodePath = path.join(dirPath, fileSystemNode);
    const nodeStats = await fs.stat(nodePath);

    if (nodeStats.isDirectory()) {
      await findFiles(nodePath, arrayOfFiles, findFilesCallback);
    } else {
      findFilesCallback(nodePath) && arrayOfFiles.push(path.resolve(nodePath));
    }
  }

  return arrayOfFiles;
}

async function replaceLnkWithSymlinks() {
  const lnkPaths = await findFiles(LNK_LOCATION, [], isLnk);
  const errors = [];

  for (lnkPath of lnkPaths) {
    const filename = path.parse(lnkPath).name;
    let originalFilePath = 
      await findFiles(ORIGINALS_LOCATION, [], isName(filename));
    
    console.log('filename: ', filename);

    if (originalFilePath.length === 0) {
      errors.push(
        new Error(`Can't find any file(s) matchthing the link ${lnkPath}`)
      );
    } else if (originalFilePath.length > 1) {
      errors.push(
        new Error(
          'More than one file matches the link file.\nResolve the issue manually and restart the script.\n\n' + originalFilePath.join(",\n")
        )
      );
    } else {     
      console.log('Original File Path: ', originalFilePath[0]);
      console.log('Create Symlink In: ', path.parse(lnkPath).dir, '\n');
      await fs.symlink(
        originalFilePath[0], 
        `${path.parse(lnkPath).dir}/${path.parse(originalFilePath[0]).base}`
      );
      await fs.unlink(lnkPath)
    }
  };
}

replaceLnkWithSymlinks().catch(console.error);