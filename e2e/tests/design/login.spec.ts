import { test } from '@playwright/test';
import { Screens } from '../../constants/screens';
import { MoMorphScreenPage } from '../../pages/momorph-screen.page';

test.describe('[iOS] Login — MoMorph design', () => {
  test('login screen URL responds', async ({ page }) => {
    const screen = new MoMorphScreenPage(page);
    await screen.gotoScreen(Screens.login);
    await screen.expectLoaded();
  });
});
