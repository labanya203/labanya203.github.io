# labanya203.github.io
 This project contains encrypted files for data visualization project.

 # Development
 This uses [staticrypt](https://www.npmjs.com/package/staticrypt) npm library to encrypt html files to protect access via pre-determined password.

 1. Create a `.env` file in the root directory of this project. The file should specify the environment variable `STATICRYPT_PASSWORD=<hidden>` that defines what password is used to encrypt/decrypt the html files. 
    > ⚠️ **Warning:** Do not commit the `.env` file to git and publish to github.
2. Now add the html plots in the `./plots` directory, and update `index.html` to edit the list of plots.
3. Now run `git add .` and then `git commit -m "commit message"` to commit the changes. The pre-commit hook should automatically encrypt the updated html files and put them in the encrypted folder.
    > ⚠️ **Warning:** Do not commit the un-encrypted html files to github. They should only live locally. These are added in the `.gitignore` file so that git doesn't track them. Only the encrypted html files should be pushed to remote.

