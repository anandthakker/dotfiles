const { chromium } = require('playwright-core');
(async () => {
  const browser = await chromium.launch();
  try {
    const page = await browser.newPage();
    const response = await page.goto('https://example.com', {
      waitUntil: 'domcontentloaded',
      timeout: 15000,
    });
    if (!response || !response.ok()) {
      throw new Error(
        `Playwright smoke test failed: status ${response ? response.status() : 'no response'}`,
      );
    }
  } finally {
    await browser.close();
  }
})().catch((error) => {
  console.error(error);
  process.exit(1);
});
