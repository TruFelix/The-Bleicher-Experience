use setup.md beforehand.


add to tsconfig.json
```json
"compilerOptions": {
	"target": "esnext",
		"watch": true,

		"moduleResolution": "node",

		"outDir": "./out",
		"rootDir": "./src",
		
	}
```


```powershell
npm init -y
npm i express
npm i -D typescript ts-node nodemon @types/node @types/express
```

package.json
```json
...
"scripts": {
	"start": "node out/app.js",
	"dev": "nodemon src/app.ts",
	"build": "tsc -p ."
}
...
```