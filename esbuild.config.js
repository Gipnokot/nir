const esbuild = require('esbuild');
const path = require('path');

const isWatch = process.argv.includes('--watch');

esbuild.build({
  entryPoints: ['app/javascript/application.js'],
  bundle: true,
  sourcemap: true,
  outdir: path.join(process.cwd(), 'app/assets/builds'),
  loader: { '.js': 'jsx', '.css': 'css' },
  plugins: [],
  watch: isWatch,
}).catch(() => process.exit(1));
