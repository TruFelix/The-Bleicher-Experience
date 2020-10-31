exec
```powershell
npm i -g typescript
tsc --version
```

app.ts
```typescript
const greeting: string= 'Hello';
const numbers: number[] = [1,2,3];
```

tsconfig.json
```json
{
	"compilerOptions": {
		"target": "esnext",
		"watch": true,

		"lib": ["dom", "es2017"],

		"outDir": "./out",
		"rootDir": "./src",
	}
}
```

exec
```powershell
tsc app.ts
```
