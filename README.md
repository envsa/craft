&nbsp;
<p align="center"><a href="https://craftcms.com/" target="_blank"><img src="https://craftcms.com/craftcms.svg" width="150" alt="Craft CMS logo" /></a></p>

## About DEWNR/craft
This is an alternate scaffolding package for Craft 3 CMS projects to Pixel & Tonic's canonical [craftcms/craft](https://github.com/craftcms/craft) package.

This project has been built following base principals from Andrew Welch's scaffolding project [nystudio107/craft](https://github\.com/nystudio107/craft) package. 

## Key technologies
- [Laravel mix](https://laravel.com/docs/5.8/mix#introduction) is used for the build system as per [ben-rogerson/agency-webpack-mix-config](https://github.com/ben-rogerson/agency-webpack-mix-config)
- [Tailwind CSS](https://tailwindcss.com/) for the site-wide CSS
- Implements a Service Worker via Google's [Workbox](https://developers.google.com/web/tools/workbox/)
- Critical CSS

## Craft plugins
<img src="https://pluginicons.craft-cdn.com/aws-s3.svg" width="15" height="15">[Amazon S3](https://plugins.craftcms.com/aws-s3) - Remote asset volumes  
<img src="https://pluginicons.craft-cdn.com/feed-me.svg" width="15" height="15"> [Feed me](https://plugins.craftcms.com/feed-me) - All of your migratory needs  
<img src="https://pluginicons.craft-cdn.com/redactor.svg" width="15" height="15"> [Redactor](https://plugins.craftcms.com/redactor) - WYSIWYGs still exist  
<img src="https://pluginicons.craft-cdn.com/image-optimize.svg" width="15" height="15"> [Image Optimize](https://plugins.craftcms.com/image-optimize) - Optimize those images  
<img src="https://pluginicons.craft-cdn.com/minify.svg" width="15" height="15"> [Minify](https://plugins.craftcms.com/minify) - Compress those templates  
<img src="https://pluginicons.craft-cdn.com/retourvJWvV81vAbn12iI0ai3823Qe4J9ukz4SmvkF.svg" width="15" height="15"> [Retour](https://plugins.craftcms.com/retour) - Handle 404 errors  
<img src="https://pluginicons.craft-cdn.com/seomatic.svg" width="15" height="15"> [Seomatic](https://plugins.craftcms.com/seomatic) - Best practice SEO with ease  
<img src="https://pluginicons.craft-cdn.com/typogrify.svg" width="15" height="15"> [Typogrify](https://plugins.craftcms.com/typogrify) - Helpful for typography consistency  
<img src="https://pluginicons.craft-cdn.com/twigpackkb2n7SgCbjImm1ixSayBzRPwdQUkMpxCl8IF.svg" width="15" height="15"> [Twigpack](https://plugins.craftcms.com/twigpack) - A link between our MIX build and our twig templates  
<img src="https://pluginicons.craft-cdn.com/dumper.svg" width="15" height="15"> [Dumper](https://plugins.craftcms.com/craft-dumper) - Improves our dev experience

## NPM
Built with Node v11.5.0 and NPM v6.4.1
Run from commad line `npm install`

## Generate favicons
1. Add favicon file to src/images/favicon_src.[ext]
2. Make sure that the file extension for the source image is correct in ./favicon.json (masterPicture)
3. Run from command line `npm run generate-favicons`

## Build Instructions
1. Build favicons (see below)
2. Run Mix build [insert scripts here]


## TODO (Dreams :last_quarter_moon_with_face:)
- Update scripts to TS​
