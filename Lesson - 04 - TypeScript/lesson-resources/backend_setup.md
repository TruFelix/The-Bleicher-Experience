## Install required packages


```powershell
npm install -g typescript
npm init
npm install express
npm install -D typescript ts-node nodemon @types/node @types/express
```

## Config file for TypeScript

create `tsconfig.json` with `npx tsc --init`

only used settings are listed here
```json
{
	"ts-node": {
		// these options are overrides used only by ts-node
		// same as our --compilerOptions flag and our TS_NODE_COMPILER_OPTIONS environment variable
		"compilerOptions": {
			"module": "commonjs"
		}
	},
	"compilerOptions": {
		/* Visit https://aka.ms/tsconfig.json to read more about this file */
		
		"strict": true,                           /* Enable all strict type-checking options. */
		"target": "ESNext",                       /* Specify ECMAScript target version: 'ES3' (default), 'ES5', 'ES2015', 'ES2016', 'ES2017', 'ES2018', 'ES2019', 'ES2020', or 'ESNEXT'. */
		
		"module": "ESNext",                       /* Specify module code generation: 'none', 'commonjs', 'amd', 'system', 'umd', 'es2015', 'es2020', or 'ESNext'. */
		"esModuleInterop": true,                  /* Enables emit interoperability between CommonJS and ES Modules via creation of namespace objects for */
		
		"lib": ["ESNext"],                        /* Specify library files to be included in the compilation. */
			
		"skipLibCheck": true,                     /* Skip type checking of declaration files. */
		"forceConsistentCasingInFileNames": true, /* Disallow inconsistently-cased references to the same file. */
		
		"outDir": "./out",
		"rootDir": "./src",
	}
}
```


## Package-Scripts

package.json
```json
...
"type": "module",
"scripts": {
	"start": "ts-node ./src/server.ts",
	"dev": "nodemon --exec ts-node ./src/server.ts",
	"build": "tsc -p ."
},

"dependencies": {
	"express": "^4.17.1"
},
"devDependencies": {
	"@types/express": "^4.17.8",
	"@types/node": "^14.14.6",
	"nodemon": "^2.0.6",
	"ts-node": "^9.0.0",
	"typescript": "^4.0.5"
}
...

```