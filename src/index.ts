import { registerPlugin } from '@capacitor/core';

import type { ElevenStreamingPlugin } from './definitions';

const ElevenStreaming = registerPlugin<ElevenStreamingPlugin>(
  'ElevenStreaming',
  {
    web: () => import('./web').then(m => new m.ElevenStreamingWeb()),
  },
);

export * from './definitions';
export { ElevenStreaming };
