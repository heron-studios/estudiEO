const express = require('express');
const puppeteer = require('puppeteer');
const path = require('path');

const app = express();
const port = 8080;

app.use('/EstudiEO-flutter', express.static(path.join(__dirname, 'build/web')));

app.listen(port, async () => {
  console.log(`Server running at http://localhost:${port}/EstudiEO-flutter/`);
  
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  
  page.on('console', msg => {
    console.log(`[BROWSER CONSOLE] ${msg.type().toUpperCase()}: ${msg.text()}`);
  });
  
  page.on('pageerror', err => {
    console.error(`[BROWSER ERROR] ${err.toString()}`);
  });

  console.log('Navigating to http://localhost:8080/EstudiEO-flutter/');
  await page.goto('http://localhost:8080/EstudiEO-flutter/', { waitUntil: 'networkidle0', timeout: 60000 });
  
  console.log('Waiting 15 seconds for flutter to initialize...');
  await new Promise(resolve => setTimeout(resolve, 15000));
  
  await page.screenshot({ path: 'screenshot.png' });
  console.log('Screenshot saved to screenshot.png');
  
  await browser.close();
  process.exit(0);
});
