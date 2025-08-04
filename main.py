import streamlit as st
from utils.ui import display_ui
from utils.chat import handle_chat

def main():
    display_ui()
    openai_api_key = st.text_input("OpenAI API Key", type="password")

    if not openai_api_key:
        st.info("Please add your OpenAI API key to continue.", icon="🗝️")
    else:
        handle_chat(openai_api_key)

if __name__ == "__main__":
    main()
