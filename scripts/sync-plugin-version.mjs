#!/usr/bin/env node
// package.json의 버전을 .claude-plugin/plugin.json으로 복사합니다.
// `npm run version`의 일부로, `changeset version` 직후에 실행됩니다.
// --check를 주면 아무것도 바꾸지 않고, 두 버전이 다르면 1로 종료합니다.

import { readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const repo = join(dirname(fileURLToPath(import.meta.url)), "..");
const pluginPath = join(repo, ".claude-plugin", "plugin.json");

const { version } = JSON.parse(readFileSync(join(repo, "package.json"), "utf8"));
const source = readFileSync(pluginPath, "utf8");
const plugin = JSON.parse(source);

if (plugin.version === version) {
  console.log(`plugin.json 버전은 ${version}입니다 (이미 동기화됨)`);
  process.exit(0);
}

if (process.argv.includes("--check")) {
  console.error(
    `plugin.json 버전은 ${plugin.version}이고 package.json은 ${version}입니다. \`node scripts/sync-plugin-version.mjs\`를 실행하세요.`,
  );
  process.exit(1);
}

// 키 순서와 서식을 유지하도록 버전 줄만 다시 씁니다.
const updated = source.replace(
  /("version"\s*:\s*")[^"]*(")/,
  `$1${version}$2`,
);

if (JSON.parse(updated).version !== version) {
  console.error(`${pluginPath}에서 교체할 version 필드를 찾을 수 없습니다.`);
  process.exit(1);
}

writeFileSync(pluginPath, updated);
console.log(`plugin.json 버전 ${plugin.version} -> ${version}`);
