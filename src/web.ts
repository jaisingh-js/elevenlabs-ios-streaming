import { WebPlugin } from '@capacitor/core';

import type { ElevenStreamingPlugin } from './definitions';

export class ElevenStreamingWeb
  extends WebPlugin
  implements ElevenStreamingPlugin
{
  private audio: HTMLAudioElement = new Audio();
  private media: MediaSource = new MediaSource();
  private sourceBuffer?: SourceBuffer;

  async initStream(): Promise<void> {
    console.log('init called');
    this.audio = new Audio();
  }

  async play(): Promise<void> {
    console.log('audio started playing');
    this.audio
      .play()
      .then(() => {
        console.log('audio started');
      })
      .catch(e => {
        console.log('audio error: ', e);
      });
  }

  async stop(): Promise<void> {
    return this.audio.pause();
  }

  async playChunk(opts: { buffer: string }): Promise<boolean> {
    console.log('buffer started adding');
    const buffer = this.base64ToArrayBuffer(opts.buffer);
    return await new Promise((resolve: any) => {
      if (!this.sourceBuffer?.updating) {
        this.sourceBuffer?.appendBuffer(buffer);
        console.log('buffer added successfully');
        if (this.audio.paused) this.play();
        resolve();
      } else {
        this.sourceBuffer.onupdateend = () => {
          this.sourceBuffer?.appendBuffer(buffer);
          console.log('buffer added successfully');
          if (this.sourceBuffer) this.sourceBuffer.onupdateend = null;
          if (this.audio.paused) this.play();
          resolve();
        };
      }
    });
  }

  async flushBuffer(): Promise<void> {
    console.log('buffer is being created');
    return new Promise(resolve => {
      this.media = new MediaSource();
      this.audio.src = window.URL.createObjectURL(this.media);
      this.media.addEventListener('sourceopen', () => {
        this.sourceBuffer = this.media.addSourceBuffer('audio/mpeg');
        console.log('source buffer added successfully');
        resolve();
        // Get video segments and append them to sourceBuffer.
      });
    });
  }

  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  private base64ToArrayBuffer(base64: string) {
    const binaryString = window.atob(base64);
    const length = binaryString.length;
    const buffer = new ArrayBuffer(length);
    const view = new Uint8Array(buffer);
    for (let i = 0; i < length; i++) {
      view[i] = binaryString.charCodeAt(i);
    }
    return view;
  }
}
