## Vector DB Use Case

For a law firm searching through 500-page contracts, a traditional keyword-based database search would likely **not suffice**. 

### The Problem with Keywords
Traditional databases (like MySQL) rely on "Exact Matching" or "Lexical Search." If a lawyer searches for "termination clauses," the system will only return sections containing those exact words. However, a legal contract might use different phrasing, such as "Conditions for Rescission," "Period of Expiry," or "Dissolution of Agreement." A keyword search would miss these relevant sections entirely because the words don't match, even though the **meaning** is the same.

### The Role of a Vector Database
A Vector Database solves this by using **Semantic Search**. It converts the text of the contracts into high-dimensional numerical arrays called **embeddings**. These embeddings place similar concepts close together in a mathematical "vector space." 

In this system:
1. **Contextual Understanding:** The Vector DB understands that "termination" and "dissolution" are semantically related. When a lawyer asks a question in plain English, the system finds the sections with the most similar "meaning" rather than just matching characters.
2. **Efficient Retrieval:** Even with thousands of pages, a Vector DB can perform a "Nearest Neighbor" search almost instantly. 
3. **Foundation for RAG:** This database acts as the "long-term memory" for an AI model. Once the Vector DB finds the relevant clause, it can pass that specific text to a Large Language Model (LLM) to summarize the answer for the lawyer, ensuring the response is grounded in the actual contract.
