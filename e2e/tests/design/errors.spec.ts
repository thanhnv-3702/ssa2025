import { test } from '@playwright/test';
import { Screens } from '../../constants/screens';
import { MoMorphScreenPage } from '../../pages/momorph-screen.page';

test.describe('[iOS] Error screens — MoMorph design', () => {
  test('Not Found screen URL responds', async ({ page }) => {
    const screen = new MoMorphScreenPage(page);
    await screen.gotoScreen(Screens.notFound);
    await screen.expectLoaded();
  });

  test('Access denied screen URL responds', async ({ page }) => {
    const screen = new MoMorphScreenPage(page);
    await screen.gotoScreen(Screens.accessDenied);
    await screen.expectLoaded();
  });
});
