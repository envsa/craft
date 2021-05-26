
&nbsp;
<p  align="center"><a  href="https://craftcms.com/"  target="_blank"><img  src="https://craftcms.com/craftcms.svg"  width="150"  alt="Craft CMS logo" /></a></p>


## About envsa/craft

This is an alternate scaffolding package for Craft 3 CMS projects to Pixel & Tonic's canonical [craftcms/craft](https://github.com/craftcms/craft) package.  

This project has been built following base principals from Andrew Welch's scaffolding project [nystudio107/craft](https://github.com/nystudio107/craft/tree/2.1.1) package (as at version 2.1.1).
  

## Using envsa/craft

This project package works exactly the way Pixel & Tonic's [craftcms/craft](https://github.com/craftcms/craft) package works; you create a new project by first creating & installing the project:

```sh
composer create-project envsa/craft PATH
```

Make sure that `PATH` is the path to your project, including the name you want for the project, eg.:

```sh
composer create-project envsa/craft craft3
``` 

Say `no` when prompted to start the craft setup, then `cd` to your new project directory.  

```sh
cd PATH
``` 

The next step will depend on your local dev setup, we'll be using [nitro](https://github.com/craftcms/nitro).

```sh
nitro add
```  

- Hostname: [craft3.nitro]
- Web root: [web]
- PHP version: [7.4]
- Add a db for the site: [Y]  [craft3]
- Update the .env file: [Y]
- Apply changes [Y]

You will also need to update the `.env` file with the `SITE_URL` that you chose for the hostname.

```sh
nitro db import starterbase.sql
```

When prompted use the db that you specified in the previous step [craft3]


Run Craft's `setup` console command to create your environment:

```sh
./craft setup
```
  
Finally we need to build our assets.

```sh
nvm use
npm install
npx install-peerdeps --dev @envsa/eslint-config
npm run build
```

You should be ready to go, visit the your url and test it out.

Default login
```
dew.internet@sa.gov.au
password
```
