import { test } from '@playwright/test';
import { Screens } from '../../constants/screens';
import { MoMorphScreenPage } from '../../pages/momorph-screen.page';

test.describe('[iOS] Notifications — MoMorph design', () => {
  test('notifications screen URL responds', async ({ page }) => {
    const screen = new MoMorphScreenPage(page);
    await screen.gotoScreen(Screens.notifications);
    await screen.expectLoaded();
  });
});
