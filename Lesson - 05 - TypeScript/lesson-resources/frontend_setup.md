exec
```powershell
npm i -g typescript
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
		"outDir": "./out",
		"rootDir": "./src",

		"strict": true,
		"target": "ESNext",
		"module": "ESNext",
		"lib": ["ESNext", "DOM"],
		"esModuleInterop": true,
		
		"skipLibCheck": true,
		"forceConsistentCasingInFileNames": true,
		
	}
}
```

exec
```powershell
tsc app.ts
```
