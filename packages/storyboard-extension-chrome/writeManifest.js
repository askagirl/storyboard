const fs = require('fs');
const pkg = require('./package.json');

const manifest = {
  manifest_version: 2,

  name: 'Storyboard DevTools',
  short_name: 'Storyboard DevTools',
  description: 'Gives you access to end-to-end stories (logs) for Storyboard-equipped applications',
  author: 'Guillermo Grau Panea',
  version: pkg.version.split('-')[0],

  content_scripts: [{
    matches: ['<all_urls>'],
    js: ['contentScript.js'],
    run_at: 'document_start',
  }],

  background: {
    scripts: ['background.js'],
    persistent: false,
  },

  devtools_page: 'devTools.html',

  icons: {
    16: 'Logo16.png',
    32: 'Logo32.png',
    48: 'Logo48.png',
    128: 'Logo128.png',
  },
};

const manifestJson = `${JSON.stringify(manifest, null, '  ')}\n`;
fs.writeFileSync('lib/public/manifest.json', manifestJson);
