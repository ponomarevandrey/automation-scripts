const bcrypt = require("bcrypt");
const input = process.argv[2];

async function hashPassword(password, saltRounds = 10) {
  const salt = await bcrypt.genSalt(saltRounds);
  return await bcrypt.hash(password, salt);
}

async function isPasswordMatch(password, hash) {
  try {
    return await bcrypt.compare(password, hash);
  } catch (err) {
    logger.error(`${__filename}: ${err}`);
    return false;
  }
}

console.log(`Original input value: ${input}`);

hashPassword(input)
  .then(hash => {
    console.log(`Hashed input value: ${hash}`);
    return hash;
  })
  .then(hash => {
    return isPasswordMatch(input, hash);
  })
  .then(isMatched => {
    console.log(`Test. Input matches generated hash: `, isMatched);
   })
  .catch(console.error);


