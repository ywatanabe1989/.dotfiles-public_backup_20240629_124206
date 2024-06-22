#!/home/ywatanabe/env-3.11/bin/python

import argparse
import json
import os
import re
import sys
import time

import mngs
from mngs.ai import GenAI as mngs_ai_GenAI
from mngs.gen import natglob as mngs_gen_natglob
from mngs.io import load as mngs_io_load
from mngs.io import save as mngs_io_save
from mngs.path import split as mngs_path_split

# PATHs
# __file__ = "/home/ywatanabe/.dotfiles/.emacs.d/lisp/emacs-genai/emacs-genai.py"


def load_templates():
    TEMPLATE_DIR = mngs_path_split(__file__)[0] + "./templates/"
    TEMPLATE_PATHS = mngs_gen_natglob(TEMPLATE_DIR + "*")

    TEMPLATE_NAMES = ["".join(mngs_path_split(l)[1:]) for l in TEMPLATE_PATHS]

    TEMPLATES = {}
    for lpath, fname in zip(TEMPLATE_PATHS, TEMPLATE_NAMES):
        template_type = fname.split(".")[0]
        prompt = mngs_io_load(lpath, verbose=False)
        TEMPLATES[template_type] = prompt

    return TEMPLATES


def print_splitter(role=None):
    print(f"\n\n{'='* 60}\n")
    if role:
        print(f"{role}\n")


def concat_lines(lpath):
    prompt = [f"{line}\n" for line in mngs_io_load(lpath)]
    return "".join(prompt)


def update_human_chat_history(
    human_chat_history, history_file, template_type, prompt, model_out
):
    human_chat_history.append(
        {"role": f"user (Template: {str(template_type)})", "content": prompt}
    )
    human_chat_history.append({"role": "assistant", "content": model_out})
    mngs.io.save(human_chat_history, history_file, verbose=False)


def update_ai_chat_history(ai_chat_history, ai_history_file, model):
    n_new_history = 2
    for history in model.chat_history[-n_new_history:]:
        ai_chat_history.append(history)
    mngs.io.save(ai_chat_history, ai_history_file, verbose=False)


def run_genai(
    api_key,
    engine,
    max_tokens,
    temperature,
    history_file,
    template_type,
    n_history,
    prompt,
):
    # Parameters
    TEMPLATES = load_templates()

    if template_type == "None":
        template_type = ""

    # Initialize model with chat_history
    human_chat_history = mngs_io_load(history_file)
    ai_history_file = history_file.replace("history", "history-ai")
    ai_chat_history = mngs_io_load(ai_history_file)

    model = mngs_ai_GenAI(model=engine, stream=True, n_keep=n_history)
    [
        model.update_history(**_history)
        for _history in ai_chat_history[-n_history - 1 :]
    ]

    # Embeds the prompt into template
    template = TEMPLATES.get(template_type, f"{template_type}\n\nPLACEHOLDER")
    ai_prompt = template.replace("PLACEHOLDER", prompt)

    # GENAI
    print_splitter(engine.upper())

    # fixme; scroll

    if prompt.strip() == "":
        model_out = "Please input prompt"
        print(model_out)
        print()
    else:
        model_out = model(ai_prompt)
        print()
    # print_splitter()

    # Update emacs-genai's chat-history
    update_human_chat_history(
        human_chat_history, history_file, template_type, prompt, model_out
    )
    update_ai_chat_history(ai_chat_history, ai_history_file, model)


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="")
    parser.add_argument(
        "--api_key",
        type=str,
        default=os.getenv("GENAI_API_KEY"),
        help="(default: %(default)s)",
    )

    parser.add_argument(
        "--engine",
        type=str,
        default="gemini-1.5-pro-latest",
        help="(default: %(default)s)",
    )

    parser.add_argument(
        "--max_tokens",
        type=int,
        default=4096,
        help="(default: %(default)s)",
    )

    parser.add_argument(
        "--temperature",
        type=int,
        default=0,
        help="(default: %(default)s)",
    )

    parser.add_argument(
        "--prompt_file",
        type=str,
        default=None,
        help="(default: %(default)s)",
    )

    parser.add_argument(
        "--history_file",
        type=str,
        default=mngs.path.split(__file__)[0] + "./history-secret.json",
        help="(default: %(default)s)",
    )

    parser.add_argument(
        "--n_history",
        type=int,
        default=5,
        help="(default: %(default)s)",
    )

    parser.add_argument(
        "--template_type",
        type=str,
        default="",
        help="(default: %(default)s)",
    )

    parser.add_argument(
        "--prompt",
        type=str,
        default="Hi!",
        help="(default: %(default)s)",
    )

    args = parser.parse_args()
    # mngs.gen.print_block(args, c="yellow")

    run_genai(
        api_key=args.api_key,
        engine=args.engine,
        max_tokens=args.max_tokens,
        temperature=args.temperature,
        history_file=args.history_file,
        template_type=args.template_type,
        n_history=args.n_history,
        prompt=args.prompt,
    )
