#utils/ui.py

import streamlit as st

def display_ui():
    st.set_page_config(page_title="💬 Chatbot")
    st.title("💬 Chatbot")
    st.write(
        "This is a simple chatbot that uses OpenAI's GPT-3.5 model to generate responses. "
        "To use this app, you need to provide an OpenAI API key, which you can get [here](https://platform.openai.com/account/api-keys)."
    )
