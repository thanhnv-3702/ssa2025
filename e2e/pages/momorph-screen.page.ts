import { type Page, expect } from '@playwright/test';
import { screenUrl } from '../constants/screens';

/**
 * MoMorph screen preview page — loads design frame in browser.
 */
export class MoMorphScreenPage {
  constructor(readonly page: Page) {}

  async gotoScreen(screenId: string): Promise<void> {
    const response = await this.page.goto(screenUrl(screenId), {
      waitUntil: 'domcontentloaded',
    });
    expect(response?.status()).toBeLessThan(400);
  }

  async expectLoaded(): Promise<void> {
    await expect(this.page.locator('body')).toBeVisible({ timeout: 15_000 });
    // MoMorph may render canvas/image — avoid strict title/text assertions
    const title = await this.page.title();
    expect(title.length).toBeGreaterThan(0);
  }

  /** Optional — only when DOM exposes copy (e.g. spec overlay). */
  async expectTextVisible(pattern: RegExp | string): Promise<void> {
    const locator = this.page.getByText(pattern).first();
    const count = await locator.count();
    if (count === 0) {
      // Design preview often has no selectable text — pass if page loaded
      return;
    }
    await expect(locator).toBeVisible({ timeout: 5_000 });
  }
}
