# FlutterFlow Action Flow Guide: On-Device Embeddings

> Use this guide to set up **on-device AI text embeddings** in your FlutterFlow project using the Action Flow Editor.

---

## Overview

This library provides 4 Custom Actions for building RAG (Retrieval-Augmented Generation) features:

| Custom Action | Purpose |
|---------------|---------|
| `downloadEmbeddingModel` | Downloads the AI model to the device (one-time) |
| `processDocumentsToVectors` | Converts text into embedding vectors |
| `saveVectorsToDb` | Saves vectors to local SQLite database |
| `findTopMatches` | Searches vectors by semantic similarity |

---

## Before You Start

### Required Custom Data Type

Create a **Custom Data Type** called `VectorDocumentStruct`:

1. **Left Panel** → **Custom Data Types** → **+ Create**
2. **Name:** `VectorDocumentStruct`
3. **Add Fields:**

| Field | Type | List? |
|-------|------|-------|
| id | String | No |
| text | String | No |
| vector | Double | **Yes** |
| metadata | String | No |

### Required App State Variables

1. **Left Panel** → **App State** → **+ Add Variable**

| Name | Type | List? | Persisted? |
|------|------|-------|------------|
| isModelReady | Boolean | No | **Yes** |
| allVectors | VectorDocumentStruct | **Yes** | No |

---

## Model URLs (Copy These Exactly)

You'll need these when configuring `downloadEmbeddingModel`:

**Model URL:**
```
https://huggingface.co/litert-community/Gecko-110m-en/resolve/main/Gecko_256_quant.tflite
```

**Tokenizer URL:**
```
https://huggingface.co/litert-community/Gecko-110m-en/resolve/main/sentencepiece.model
```

---

## Action Flow 1: Download Model (Splash Screen)

**Location:** Add to your Splash Screen or Loading Page  
**Trigger:** On Page Load

### Step-by-Step in Action Flow Editor

1. **Select Page** → Click page canvas (not a widget)
2. **Properties Panel** → **Actions** → **On Page Load** → **Open**

#### Add Actions in This Order:

**Action 1: Condition**
| Setting | Value |
|---------|-------|
| Type | Single Condition |
| First Value | **App State** → `isModelReady` |
| Operator | Equal To |
| Second Value | **Specific Value** → `true` |

---

**TRUE Branch (Model Already Downloaded):**

**Action 1.1: Navigate To**
| Setting | Value |
|---------|-------|
| Navigation Type | Go To Page |
| Page | Your Home Page |

---

**FALSE Branch (Need to Download):**

**Action 1.2: Custom Action**
| Setting | Value |
|---------|-------|
| Action | `downloadEmbeddingModel` |
| modelUrl | `https://huggingface.co/litert-community/Gecko-110m-en/resolve/main/Gecko_256_quant.tflite` |
| tokenizerUrl | `https://huggingface.co/litert-community/Gecko-110m-en/resolve/main/sentencepiece.model` |
| **Action Output Variable Name** | `downloadResult` |

**Action 1.3: Condition**
| Setting | Value |
|---------|-------|
| First Value | **Action Output** → `downloadResult` |
| Operator | Equal To |
| Second Value | **Specific Value** → `Success` |

**TRUE Path (Download Success):**

**Action 1.3.1: Update App State**
| Setting | Value |
|---------|-------|
| Field to Update | `isModelReady` |
| Update Type | Set Value |
| Value | `true` |

**Action 1.3.2: Navigate To**
| Setting | Value |
|---------|-------|
| Page | Your Home Page |

**FALSE Path (Download Failed):**

**Action 1.3.3: Show Snack Bar**
| Setting | Value |
|---------|-------|
| Message | `Model download failed. Check internet connection.` |

---

### Visual Summary

```
On Page Load
├── Condition: isModelReady == true?
│   ├── TRUE → Navigate To: Home Page
│   └── FALSE
│       ├── Custom Action: downloadEmbeddingModel
│       └── Condition: downloadResult == "Success"?
│           ├── TRUE
│           │   ├── Update App State: isModelReady = true
│           │   └── Navigate To: Home Page
│           └── FALSE → Show Snack Bar: "Download failed"
```

---

## Action Flow 2: Generate & Save Embeddings

**Location:** Button on your Add Content / Import page  
**Trigger:** On Tap

### Prerequisites

Create a **Page State Variable** to hold your documents:

1. **Select Page** → **Page State** → **+ Add Variable**
2. **Name:** `documentsToIndex`
3. **Type:** String
4. **Is List:** Yes

*(Populate this list from user input, file upload, or API)*

### Step-by-Step in Action Flow Editor

1. **Select Button** → **Properties Panel** → **Actions** → **On Tap** → **Open**

#### Add Actions in This Order:

**Action 1: Custom Action**
| Setting | Value |
|---------|-------|
| Action | `processDocumentsToVectors` |
| documents | **Page State** → `documentsToIndex` |
| **Action Output Variable Name** | `vectorDocs` |

**Action 2: Custom Action**
| Setting | Value |
|---------|-------|
| Action | `saveVectorsToDb` |
| vectors | **Action Output** → `vectorDocs` |

**Action 3: Update App State**
| Setting | Value |
|---------|-------|
| Field to Update | `allVectors` |
| Update Type | Set Value |
| Value | **Action Output** → `vectorDocs` |

**Action 4: Show Snack Bar**
| Setting | Value |
|---------|-------|
| Message | `Saved documents to database!` |

---

### Visual Summary

```
On Tap (Save Button)
├── Custom Action: processDocumentsToVectors
│   └── Input: documentsToIndex → Output: vectorDocs
├── Custom Action: saveVectorsToDb
│   └── Input: vectorDocs
├── Update App State: allVectors = vectorDocs
└── Show Snack Bar: "Saved documents!"
```

---

## Action Flow 3: Search Documents

**Location:** Search Button or TextField on Search page  
**Trigger:** On Tap or On Submit

### Prerequisites

Create **Page State Variables**:

| Name | Type | List? |
|------|------|-------|
| searchQuery | String | No |
| searchResults | VectorDocumentStruct | **Yes** |

### Step-by-Step in Action Flow Editor

1. **Select Search Button** → **Properties Panel** → **Actions** → **On Tap** → **Open**

#### Add Actions:

**Action 1: Custom Action**
| Setting | Value |
|---------|-------|
| Action | `findTopMatches` |
| query | **Widget State** → TextField value *OR* **Page State** → `searchQuery` |
| documents | **App State** → `allVectors` |
| topK | `5` *(or your preferred number)* |
| **Action Output Variable Name** | `matchedDocs` |

**Action 2: Update Page State**
| Setting | Value |
|---------|-------|
| Field to Update | `searchResults` |
| Update Type | Set Value |
| Value | **Action Output** → `matchedDocs` |

---

### Visual Summary

```
On Tap (Search Button)
├── Custom Action: findTopMatches
│   └── Input: query, allVectors, 5 → Output: matchedDocs
└── Update Page State: searchResults = matchedDocs
```

### Displaying Results

Bind a **ListView** to **Page State** → `searchResults`:

- **Text Widget:** `searchResults[index].text`
- **Subtitle:** `searchResults[index].metadata`

---

## Alternative: GenerateEmbeddings Widget

Instead of manually chaining Actions 2a + 2b, use the **Custom Widget**:

1. **Widget Palette** → **Components** → **Custom Widgets**
2. **Drag `GenerateEmbeddings`** onto your page
3. **Configure:**

| Parameter | Value |
|-----------|-------|
| width | `double.infinity` or specific width |
| height | `150` |
| documents | **Page State** → `documentsToIndex` |

4. **Add Callback Actions:**
   - **onComplete** → Show Snack Bar, Update App State, etc.
   - **onError** → Show Snack Bar with error message

The widget handles progress display and button state automatically.

---

## Quick Reference: Action Chain Order

| Step | Use Case | Actions (in order) |
|------|----------|-------------------|
| 1 | First app launch | `downloadEmbeddingModel` → Update App State |
| 2 | Adding documents | `processDocumentsToVectors` → `saveVectorsToDb` → Update App State |
| 3 | Searching | `findTopMatches` → Update Page State |

---

## Common Issues

### "No active embedding model set"

**Cause:** Model not downloaded before generating embeddings.

**Fix:** Ensure Action Flow 1 runs successfully on app launch. Check that `isModelReady` App State is `true` before allowing access to embedding features.

### Empty Search Results

**Cause:** `allVectors` App State is empty.

**Fix:** 
1. Run Action Flow 2 to index documents first
2. Verify `allVectors` was updated after `saveVectorsToDb`

### Download Stuck or Failed

**Cause:** Network issue or large file (~114MB).

**Fix:**
1. Check device internet connection
2. The download is resumable—retry the action
3. Ensure URLs are copied exactly (no trailing spaces)

---

## Summary

| When | Where | What to Do |
|------|-------|------------|
| App Launch | Splash Screen → On Page Load | Download model if `isModelReady` is false |
| User Adds Content | Button → On Tap | Process → Save → Update App State |
| User Searches | Search Button → On Tap | Find matches → Update Page State → Display |

All processing happens **on-device**. No API keys. No cloud costs. Works offline after model download.
