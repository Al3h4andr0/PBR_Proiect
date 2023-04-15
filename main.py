import tkinter as tk
import nltk
from nltk.corpus import cmudict
from pyswip import Prolog
# Load the CMU Pronouncing Dictionary
# d = cmudict.dict()
# prolog = Prolog()
# prolog.consult("split.pl")

prolog2 = Prolog()
prolog2.consult("C://Users//ioan_//Documents//an3//Sem2//PBR//proiect//test.pl")

print(prolog2.assertz("father(john,jim)."))

result = list(prolog2.query("grandfather(john,x)."))
print(result)
# def syllabify(word):
#     # Define a list of vowels in Romanian
#     vowels = ['a', 'e', 'i', 'o', 'u', 'ă', 'î', 'â']

#     # Initialize an empty list to store syllables
#     syllables = []

#     # Convert the word to lowercase for consistency
#     word = word.lower()

#     # Iterate through each character in the word
#     for i, char in enumerate(word):
#         if char in vowels:
#             # If the character is a vowel, add it to the current syllable
#             if i>0 : 
#                 syllables[-1] += char
#             else:
#                 syllables += char
#         elif syllables and syllables[-1][-1] not in vowels:
#             # If the previous syllable ends with a consonant, add the character
#             # to the current syllable
#             syllables[-1] += char
#         else:
#             # Otherwise, start a new syllable with the current character
#             syllables.append(char)

#     # Join the syllables into a string and return
#     return '-'.join(syllables)


# def process_word():
#     word = entry_word.get()
#     syllables = prolog.query(f"insert_hyphen({word})")
#     all_words = get_all_words(word, syllables)
#     label_syllables.config(text=f"Syllables: {syllables}")
#     # label_all_words.config(text=f"All Words: {', '.join(all_words)}")
#     label_all_words.config(text=f"All Words: teste sa vad cum arata")

# def get_syllables(word):
#     # Function to get syllables for a word using CMU Pronouncing Dictionary
#     word = word.upper()
#     try:
#         syllables = ' '.join(['-'.join(phone) for phone in d[word][0]])
#     except KeyError:
#         syllables = "Not found"
#     return syllables

# def get_all_words(word, syllables):
#     # Function to generate all words from syllables
#     all_words = []
#     for syllable in syllables.split():
#         # Split syllable by "-"
#         parts = syllable.split("-")
#         for part in parts:
#             # Replace "-" with ""
#             word = word.replace(part, "", 1)
#         all_words.append(word)
#         word = entry_word.get()  # Reset word to original value
#     return all_words

# # Create a window
# window = tk.Tk()
# window.title("Word Processor")

# # Add UI components
# label_word = tk.Label(window, text="Enter a word:")
# label_word.grid(row=0, column = 0, padx=5, pady=10)

# entry_word = tk.Entry(window)
# entry_word.grid(row=0, column=1, padx=5, pady=10)


# button_process = tk.Button(window, text="Process", command=process_word)
# button_process.grid(row=1, column=0, columnspan = 2, pady = 5)

# label_syllables = tk.Label(window, text="Syllables: ")
# label_syllables.grid(row = 2, column = 0, columnspan = 2, pady = 10)


# label_all_words = tk.Label(window, text="All Words: ")
# label_all_words.grid(row=3, column = 0, columnspan = 2, pady=10)
# window.geometry("250x200")
# window.configure(bg = "light gray")
# # Start the event loop
# window.mainloop()
