# elevenlabs-ios-streaming

Enables IOS streaming for elevenlabs

## Install

```bash
npm install elevenlabs-ios-streaming
npx cap sync
```

## API

<docgen-index>

* [`initStream()`](#initstream)
* [`stop()`](#stop)
* [`flushBuffer()`](#flushbuffer)
* [`playChunk(...)`](#playchunk)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### initStream()

```typescript
initStream() => Promise<void>
```

--------------------


### stop()

```typescript
stop() => Promise<void>
```

--------------------


### flushBuffer()

```typescript
flushBuffer() => Promise<void>
```

--------------------


### playChunk(...)

```typescript
playChunk(opts: { buffer: string; }) => Promise<boolean>
```

| Param      | Type                             |
| ---------- | -------------------------------- |
| **`opts`** | <code>{ buffer: string; }</code> |

**Returns:** <code>Promise&lt;boolean&gt;</code>

--------------------

</docgen-api>
