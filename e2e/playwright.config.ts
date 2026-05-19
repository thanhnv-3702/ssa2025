import { defineConfig, devices } from '@playwright/test';
import dotenv from 'dotenv';
import path from 'path';

dotenv.config({ path: path.resolve(__dirname, '.env') });

const momorphBase = process.env.MOMORPH_BASE_URL ?? 'https://momorph.ai/files/9ypp4enmFmdK3YAFJLIu6C/screens';
const appBase = process.env.APP_BASE_URL;

/**
 * SAA 2025 E2E — MoMorph design screens (public preview) + placeholders for web app.
 * Flutter mobile: use `app/app/integration_test/` for on-device smoke tests.
 */
export default defineConfig({
  testDir: './tests',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 2 : undefined,
  reporter: [['html', { open: 'never' }], ['list']],
  use: {
    baseURL: momorphBase,
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',
  },
  projects: [
    {
      name: 'design-chromium',
      testMatch: /design\/.*\.spec\.ts/,
      use: { ...devices['Desktop Chrome'] },
    },
    ...(appBase
      ? [
          {
            name: 'app-chromium',
            testMatch: /app\/.*\.spec\.ts/,
            use: {
              ...devices['Desktop Chrome'],
              baseURL: appBase,
            },
          },
        ]
      : []),
  ],
  outputDir: 'test-results',
});
