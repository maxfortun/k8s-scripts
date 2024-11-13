#!/usr/bin/env node

if(process.argv.length < 3) {
	console.log("Extract text only data from k8s CRI");
	console.log("Usage: "+process.argv[0]+" "+process.argv[1]+" <file.og> [file.log.1] ... [file.log.N]");
	process.exit();
}

const fs = require('fs');
const readline = require('readline');

const loggers = {};

async function processFile(fileName) {
	const fileStream = fs.createReadStream(fileName);

	const rl = readline.createInterface({
		input: fileStream,
		crlfDelay: Infinity
	});

	for await (const line of rl) {
		const cri = JSON.parse(line);
		console.log(cri.msg);	
	}
}

async function main() {
	for(let i = 2; i < process.argv.length; i++) {
		await processFile(process.argv[i]);
	}
}

main();

