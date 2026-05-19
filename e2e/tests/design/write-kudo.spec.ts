import { test } from '@playwright/test';
import { Screens } from '../../constants/screens';
import { MoMorphScreenPage } from '../../pages/momorph-screen.page';

test.describe('[iOS] Write Kudo — MoMorph design', () => {
  test('write kudo screen URL responds', async ({ page }) => {
    const screen = new MoMorphScreenPage(page);
    await screen.gotoScreen(Screens.writeKudo);
    await screen.expectLoaded();
  });
});
