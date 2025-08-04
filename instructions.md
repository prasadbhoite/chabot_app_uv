# chabot_app_uv Project using UV

# Step 1: Go to the directory in which you want to create the project using file Explorer.
# Right click and open the terminal.

# Step 2: Create/Initiate a new project with UV:
```bash
uv init chabot_app_uv
```

# Then, change directory to the newly created project:
```bash
cd chabot_app_uv
```

# Open the terminal and type following command to check the files that were added:
# You should see a `pyproject.toml` file, a `README.md` file, and a `.gitignore` file among others.
```bash
ls -la
```

# Then, Open the project in Visual Studio Code:
```bash
code .
```
# Then, add instructions.md file to the project:
```bash
touch instructions.md
```

# Step 3: Create an instructions.md document to document each and every step.

# Step 4: Add the dependencies to the project:

```bash
uv add openai python-dotenv
```


# Activate the virtual environment:
```bash
source .venv/bin/activate
```

```bash
uv add langchain langchain-openai
```

# In UV  "pyproject.toml" file is used to manage dependencies and project configuration. It is similar to `requirements.txt` but more powerful and flexible.
# You can add dependencies to the project by using the `uv add` command followed by the package name.
# You can also specify the version of the package if needed, e.g., `uv add streamlit==1.0.0`. 
# Add the required dependencies to the project:
```bash
uv add streamlit
uv add pandas
uv add numpy
uv add streamlit --frozen
uv add gradio --frozen
```


# Gradio Application:
# Create a new file named `main.py` in the project directory and add the following code:
```python
import gradio as gr
def greet(name):
    return f"Hello {name}!"
iface = gr.Interface(fn=greet, inputs="text", outputs="text")
iface.launch()
```
# Run the Gradio application:
```bash
python main.py
```






# Step 1: Open the terminal
# Step 2: uv python install 3.11
# Step 3: uv init uv_test2
# Step 4: cd uv_test2
# Step 5: code .
# Step 6: In VS code, Check the files that were added. Open the terminal and run: uv venv --python 3.11
# Step 7: 