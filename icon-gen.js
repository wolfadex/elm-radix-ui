const fs = require("node:fs");

console.log("Gathering icons...");

fs.readdir("./public/radix-icons/", (err, files) => {
  if (err) {
    console.error(err);
  } else {
    files.forEach((fileName) => {
      fs.readFileSync(`./public/radix-icons/${fileName}`);
    });
  }
});
