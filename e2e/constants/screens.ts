/**
 * MoMorph [iOS] screen IDs — SAA 2025 file key 9ypp4enmFmdK3YAFJLIu6C
 * @see .momorph/contexts/SCREENFLOW.md
 */
export const MOMORPH_FILE_KEY = '9ypp4enmFmdK3YAFJLIu6C';

export const Screens = {
  login: '8HGlvYGJWq',
  home: 'OuH1BUTYT0',
  kudos: 'fO0Kt19sZZ',
  secretBox: 'kQk65hSYF2',
  notFound: 'sn2mdavs1a',
  accessDenied: 'k-7zJk2B7s',
  awardTopTalent: 'c-QM3_zjkG',
  writeKudo: '7fFAb-K35a',
  searchSunner: '3jgwke3E8O',
  notifications: '_b68CBWKl5',
} as const;

/** MoMorph test case counts on server (P3 sync). */
export const TestCaseCounts: Record<string, number> = {
  [Screens.login]: 20,
  [Screens.home]: 20,
  [Screens.kudos]: 39,
  [Screens.secretBox]: 5,
  [Screens.notFound]: 10,
  [Screens.notifications]: 3,
  [Screens.writeKudo]: 2,
};

export function screenUrl(screenId: string): string {
  return `/${screenId}`;
}
