# elevenlabs-ios-streaming

Enables IOS streaming for elevenlabs

## Install

```bash
npm install elevenlabs-ios-streaming
npx cap sync
```

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`initStream()`](#initstream)
* [`play()`](#play)
* [`pause()`](#pause)
* [`createBuffer()`](#createbuffer)
* [`addBuffer(...)`](#addbuffer)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### initStream()

```typescript
initStream() => Promise<void>
```

--------------------


### play()

```typescript
play() => Promise<void>
```

--------------------


### pause()

```typescript
pause() => Promise<void>
```

--------------------


### createBuffer()

```typescript
createBuffer() => Promise<void>
```

--------------------


### addBuffer(...)

```typescript
addBuffer(opts: { buffer: string; }) => Promise<boolean>
```

| Param      | Type                             |
| ---------- | -------------------------------- |
| **`opts`** | <code>{ buffer: string; }</code> |

**Returns:** <code>Promise&lt;boolean&gt;</code>

--------------------

</docgen-api>
