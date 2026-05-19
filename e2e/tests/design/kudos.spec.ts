import { test } from '@playwright/test';
import { Screens } from '../../constants/screens';
import { MoMorphScreenPage } from '../../pages/momorph-screen.page';

test.describe('[iOS] Sun*Kudos — MoMorph design', () => {
  test('kudos hub screen URL responds', async ({ page }) => {
    const screen = new MoMorphScreenPage(page);
    await screen.gotoScreen(Screens.kudos);
    await screen.expectLoaded();
  });
});
