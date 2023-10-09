export interface ElevenStreamingPlugin {
  // echo(options: { value: string }): Promise<{ value: string }>;
  initStream(): Promise<void>;
  // play(): Promise<void>;
  stop(): Promise<void>;
  flushBuffer(): Promise<void>;
  playChunk(opts: { buffer: string }): Promise<boolean>;
}
