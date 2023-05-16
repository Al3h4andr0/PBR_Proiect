import tkinter as tk
from pyswip import Prolog

# create an empty list to store the entered words
entered_words = []

def process_word():
    word = entry_word.get()
    prolog = Prolog()
    prolog.consult("retry.pl")

    result = list(prolog.query(f"insert_hyphen('{word}', Output, Ignore)"))
    output = result[0]["Output"]
    prolog_output = output

    # Convert atoms to strings
    prolog_output_strings = [str(atom) for atom in prolog_output]

    # Decode bytes to strings
    prolog_output_strings = [s.decode() if isinstance(s, bytes) else s for s in prolog_output_strings]

    prolog_output = prolog_output_strings

    # Convert b'- to -
    prolog_output = [s.replace("b'-'", "-") for s in prolog_output]

    # convert prolog_output to string
    final_output = ''.join(prolog_output)

    # update the text widget with the output
    text_output.delete(1.0, tk.END) # clear the existing text
    text_output.insert(tk.END, final_output)

    # add the entered word to the list of entered words
    entered_words.append(word)

    # update the label to show the list of entered words
    label_words["text"] = "Words used: " + ", ".join(entered_words)

def syl_sequence():
    sequence = text_syl_seq.get(1.0, tk.END)
    prolog = Prolog()
    prolog.consult("retry.pl")

    no_space_sequence = sequence.replace(" ", "")

    result = list(prolog.query(f"insert_hyphen('{no_space_sequence}', Output, Ignore)"))
    output = result[0]["Output"]
    prolog_output = output

    # Convert atoms to strings
    prolog_output_strings = [str(atom) for atom in prolog_output]

    # Decode bytes to strings
    prolog_output_strings = [s.decode() if isinstance(s, bytes) else s for s in prolog_output_strings]

    prolog_output = prolog_output_strings

    # Convert b'- to space
    prolog_output = [s.replace("b'-'", " ") for s in prolog_output]

    # convert prolog_output to string
    final_output = ''.join(prolog_output)

#     check if final_output is equal to sequence
    if final_output == sequence:
        text_syl_seq.delete(1.0, tk.END)
        text_syl_seq.insert(tk.END, "Valid Syllable Sequence")
    else:
        text_syl_seq.delete(1.0, tk.END)
        text_syl_seq.insert(tk.END, "Invalid Syllable Sequence")

# Create a window
window = tk.Tk()
window.title("Word Processor")

# Add UI components
label_word = tk.Label(window, text="Enter a word:")
label_word.grid(row=0, column=0, padx=5, pady=10)

# make a text entry box
entry_word = tk.Entry(window)
entry_word.grid(row=0, column=1, padx=5, pady=10)

# make a button
button_word = tk.Button(window, text="Process", command=process_word)
button_word.grid(row=1, column=0, padx=5, pady=10)

# add a label and a text widget to show the output
label_output = tk.Label(window, text="Syllables:")
label_output.grid(row=2, column=0, padx=5, pady=10, sticky="W")
text_output = tk.Text(window, height=1, width=30)
text_output.grid(row=2, column=1, padx=5, pady=10, sticky="W")

# add a label to show the entered words
label_words = tk.Label(window, text="Words used: ")
label_words.grid(row=3, column=0, padx=5, pady=10, sticky="W")

# add text widget saying "Syllable Sequence"
label_syl_seq = tk.Label(window, text="Syllable Sequence:")
label_syl_seq.grid(row=4, column=0, padx=5, pady=10, sticky="W")

# add text widget to write the syllable sequence
text_syl_seq = tk.Text(window, height=1, width=30)
text_syl_seq.grid(row=4, column=1, padx=5, pady=10, sticky="W")

# add a button that calls the syl_sequence function
button_syl_seq = tk.Button(window, text="Syllable Sequence", command=syl_sequence)
button_syl_seq.grid(row=5, column=0, padx=5, pady=10)

# Start the event loop
window.mainloop()
