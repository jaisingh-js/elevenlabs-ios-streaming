export interface ElevenStreamingPlugin {
  initStream(): Promise<void>;
  stop(): Promise<void>;
  flushBuffer(): Promise<void>;
  playChunk(opts: { buffer: string }): Promise<void>;
}
