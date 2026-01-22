# FlutterFlow Gemma Embeddings - Setup Guide

> A step-by-step guide for FlutterFlow users to add on-device AI embeddings to your app using the Action Flow Editor.

---

## What This Library Does

This library lets your app:
- **Generate text embeddings** (convert text into numbers that capture meaning)
- **Store embeddings locally** in SQLite
- **Search semantically** (find documents by meaning, not just keywords)

All processing happens **on the user's device** — no API calls, no cloud costs, works offline.

---

## Prerequisites

Before using the Custom Actions, complete these setup steps in FlutterFlow:

### Step 1: Add the Custom Data Type

1. Go to **Data Types** in the left sidebar
2. Click **+ Add Data Type**
3. Name it: `VectorDocumentStruct`
4. Add these fields:

| Field Name | Data Type | Is List? |
|------------|-----------|----------|
| `id` | String | No |
| `text` | String | No |
| `vector` | Double | **Yes** |
| `metadata` | String | No |

5. Click **Save**

### Step 2: Create App State Variables

1. Go to **App State** in the left sidebar
2. Add these variables:

| Variable Name | Data Type | Is List? | Persisted? | Purpose |
|---------------|-----------|----------|------------|---------|
| `isModelReady` | Boolean | No | Yes | Tracks if model is downloaded |
| `allVectors` | VectorDocumentStruct | **Yes** | No | Stores all embeddings in memory |

### Step 3: Add the Custom Actions

Ensure these Custom Actions are added to your project:
- `downloadEmbeddingModel` *(requires modelUrl AND tokenizerUrl)*
- `processDocumentsToVectors`
- `saveVectorsToDb`
- `findTopMatches`
- `initializeGemma` *(optional: call in main.dart)*

---

## Model Download URLs

**Copy these URLs exactly** — you'll need them in Workflow 1:

### Gecko Model (Recommended - No Authentication Required)

**Model URL:**
```
https://huggingface.co/litert-community/Gecko-110m-en/resolve/main/Gecko_256_quant.tflite
```

**Tokenizer URL:**
```
https://huggingface.co/litert-community/Gecko-110m-en/resolve/main/sentencepiece.model
```

> **Note:** The model is ~114MB. It downloads once and is stored on the device.

---

## Workflow 1: First-Time Model Setup

**Goal:** Download the AI model when the user first opens the app.

**Where to add this:** Your app's **Splash Screen** or **Onboarding Page**

### Action Flow Overview

```
┌─────────────────────────────────────────┐
│           ON PAGE LOAD                   │
└─────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────┐
│  Conditional: App State isModelReady    │
│  Check if: isModelReady == true         │
└─────────────────────────────────────────┘
          │                    │
     [TRUE]                [FALSE]
          │                    │
          ▼                    ▼
┌──────────────────┐  ┌───────────────────────┐
│ Navigate to      │  │ Action Block:          │
│ Home Page        │  │ downloadEmbeddingModel │
└──────────────────┘  └───────────────────────┘
                                │
                                ▼
                    ┌───────────────────────┐
                    │ Conditional:           │
                    │ downloadResult ==      │
                    │ "Success"              │
                    └───────────────────────┘
                         │            │
                    [TRUE]        [FALSE]
                         │            │
                         ▼            ▼
              ┌─────────────────┐ ┌─────────────────┐
              │ Update App State│ │ Show Snackbar:  │
              │ isModelReady =  │ │ "Download       │
              │ true            │ │ failed"         │
              ├─────────────────┤ └─────────────────┘
              │ Navigate to     │
              │ Home Page       │
              └─────────────────┘
```

### Step-by-Step Instructions

#### 1. Open the Action Flow Editor

1. Select your **Splash Screen** page
2. Click on the page background (not any widget)
3. In the Properties Panel, find **Actions**
4. Click **+ Add Action** next to **On Page Load**

#### 2. Add Conditional Check for Model Status

1. Click **+ Add Action**
2. Select **Conditional**
3. Configure:
   - **First Value:** App State → `isModelReady`
   - **Operator:** Equal To
   - **Second Value:** Specific Value → `true`

#### 3. Configure the TRUE Branch (Model Already Downloaded)

1. Under the **TRUE** branch, click **+ Add Action**
2. Select **Navigate To**
3. Choose your **Home Page**

#### 4. Configure the FALSE Branch (Need to Download)

1. Under the **FALSE** branch, click **+ Add Action**
2. Select **Custom Action**
3. Choose: `downloadEmbeddingModel`
4. Configure the parameters:

| Parameter | Value |
|-----------|-------|
| **modelUrl** | `https://huggingface.co/litert-community/Gecko-110m-en/resolve/main/Gecko_256_quant.tflite` |
| **tokenizerUrl** | `https://huggingface.co/litert-community/Gecko-110m-en/resolve/main/sentencepiece.model` |

5. Set **Action Output Variable Name:** `downloadResult`

#### 5. Add Conditional Check for Download Result

1. After the Custom Action, click **+ Add Action**
2. Select **Conditional**
3. Configure:
   - **First Value:** Action Output → `downloadResult`
   - **Operator:** Equal To
   - **Second Value:** Specific Value → `Success`

#### 6. Configure Success Path

Under the **TRUE** branch:

1. Click **+ Add Action** → **Update App State**
   - Set `isModelReady` to `true`

2. Click **+ Add Action** → **Navigate To**
   - Choose your **Home Page**

#### 7. Configure Failure Path

Under the **FALSE** branch:

1. Click **+ Add Action** → **Show Snackbar**
   - Message: `Model download failed. Please check your internet connection.`

---

## Workflow 2: Index Documents (Generate & Save Embeddings)

**Goal:** Take a list of text documents, generate embeddings, and save to the database.

**Where to add this:** A button on your **Add Documents** or **Import** page

### Action Flow Overview

```
┌─────────────────────────────────────────┐
│         ON TAP (Button)                  │
└─────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────┐
│ Action Block:                            │
│ processDocumentsToVectors               │
│ Input: Your list of text strings         │
│ Output: vectorDocs                       │
└─────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────┐
│ Action Block:                            │
│ saveVectorsToDb                         │
│ Input: vectorDocs                        │
└─────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────┐
│ Update App State:                        │
│ allVectors = vectorDocs                  │
└─────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────┐
│ Show Snackbar:                           │
│ "Saved X documents!"                     │
└─────────────────────────────────────────┘
```

### Step-by-Step Instructions

#### Prerequisites for This Page

Create a **Page State** variable to hold your documents:

1. Select your page
2. Go to **Page State**
3. Add variable:
   - **Name:** `documentsToIndex`
   - **Type:** String
   - **Is List:** Yes

#### 1. Add Action to Your Button

1. Select your "Index Documents" or "Generate Embeddings" button
2. In Properties Panel → **Actions**
3. Click **+ Add Action** next to **On Tap**

#### 2. Add processDocumentsToVectors Action

1. Click **+ Add Action**
2. Select **Custom Action**
3. Choose: `processDocumentsToVectors`
4. Configure:

| Parameter | Value |
|-----------|-------|
| **documents** | Page State → `documentsToIndex` |

5. Set **Action Output Variable Name:** `vectorDocs`

#### 3. Add saveVectorsToDb Action

1. Click **+ Add Action**
2. Select **Custom Action**
3. Choose: `saveVectorsToDb`
4. Configure:

| Parameter | Value |
|-----------|-------|
| **vectors** | Action Output → `vectorDocs` |

#### 4. Update App State

1. Click **+ Add Action**
2. Select **Update App State**
3. Configure:
   - **Field:** `allVectors`
   - **Update Type:** Set Value
   - **Value:** Action Output → `vectorDocs`

#### 5. Show Success Message

1. Click **+ Add Action**
2. Select **Show Snackbar**
3. Configure:
   - **Message:** `Successfully indexed your documents!`

---

## Workflow 3: Search Documents

**Goal:** Find documents similar to a search query.

**Where to add this:** A **Search Button** or **TextField onSubmit** on your Search page

### Action Flow Overview

```
┌─────────────────────────────────────────┐
│   ON TAP (Search Button) or             │
│   ON SUBMIT (Search TextField)          │
└─────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────┐
│ Action Block:                            │
│ findTopMatches                          │
│ Input: query, documents, topK            │
│ Output: searchResults                    │
└─────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────┐
│ Update Page State:                       │
│ results = searchResults                  │
└─────────────────────────────────────────┘
```

### Step-by-Step Instructions

#### Prerequisites for This Page

Create **Page State** variables:

1. Go to **Page State**
2. Add variables:

| Variable Name | Type | Is List? |
|---------------|------|----------|
| `searchQuery` | String | No |
| `searchResults` | VectorDocumentStruct | **Yes** |

#### 1. Connect TextField to Page State

1. Select your Search TextField
2. In Properties → **Initial Value**, leave empty
3. Set **Update Page On Change** or bind to `searchQuery`

#### 2. Add Action to Search Button

1. Select your Search button (or TextField for onSubmit)
2. In Properties Panel → **Actions**
3. Click **+ Add Action** next to **On Tap**

#### 3. Add findTopMatches Action

1. Click **+ Add Action**
2. Select **Custom Action**
3. Choose: `findTopMatches`
4. Configure:

| Parameter | Value |
|-----------|-------|
| **query** | Widget State → Search TextField value (or Page State → `searchQuery`) |
| **documents** | App State → `allVectors` |
| **topK** | `5` (or your preferred number) |

5. Set **Action Output Variable Name:** `searchResults`

#### 4. Update Page State with Results

1. Click **+ Add Action**
2. Select **Update Page State**
3. Configure:
   - **Field:** `searchResults`
   - **Update Type:** Set Value
   - **Value:** Action Output → `searchResults`

#### 5. Display Results in ListView

Your ListView should be bound to Page State → `searchResults`. Each item displays:
- `searchResults[index].text` — The document text
- `searchResults[index].metadata` — Optional metadata

---

## Alternative: Using the GenerateEmbeddings Widget

Instead of manually chaining `processDocumentsToVectors` → `saveVectorsToDb`, you can use the all-in-one Custom Widget.

### How to Use

1. Add a **Custom Widget** to your page
2. Select: `GenerateEmbeddings`
3. Configure:

| Parameter | Value |
|-----------|-------|
| **width** | Your desired width (e.g., `double.infinity`) |
| **height** | `150` |
| **documents** | Page State → `documentsToIndex` |
| **onComplete** | Add Action → Show Snackbar: "Saved {count} vectors!" |
| **onError** | Add Action → Show Snackbar: "Error: {error}" |

The widget displays:
- A status message
- A progress indicator during processing
- A "Generate Embeddings" button

---

## Troubleshooting

### "No active embedding model set" Error

**Cause:** The model wasn't downloaded before trying to generate embeddings.

**Fix:** Ensure Workflow 1 completes successfully before allowing users to index documents. Check that App State `isModelReady` is `true`.

### Empty Search Results

**Cause:** App State `allVectors` is empty.

**Fix:** 
1. Ensure documents were indexed (Workflow 2)
2. Check that `allVectors` was updated after indexing

### Download Fails

**Cause:** Network issue or incorrect URL.

**Fix:**
1. Check internet connection
2. Verify URLs are copied exactly (no extra spaces)
3. Try again — the download is resumable

### Slow Embedding Generation

**Cause:** Processing many documents at once.

**Fix:** Process documents in smaller batches (10-20 at a time).

---

## Complete Action Flow Summary

| Workflow | Trigger | Custom Action(s) | Output |
|----------|---------|------------------|--------|
| Model Setup | On Page Load (Splash) | `downloadEmbeddingModel` | "Success" or "Error" |
| Index Documents | On Tap (Button) | `processDocumentsToVectors` → `saveVectorsToDb` | List of VectorDocumentStruct |
| Search | On Tap (Button) | `findTopMatches` | Top K matching documents |

---

## Quick Reference: URLs to Copy

**Model URL:**
```
https://huggingface.co/litert-community/Gecko-110m-en/resolve/main/Gecko_256_quant.tflite
```

**Tokenizer URL:**
```
https://huggingface.co/litert-community/Gecko-110m-en/resolve/main/sentencepiece.model
```

---

## Need Help?

- Ensure all Custom Actions are properly added to your project
- Check that VectorDocumentStruct Custom Data Type matches the field names exactly
- Verify App State variables are created with correct types
- Test on a real device (embeddings require significant memory)
