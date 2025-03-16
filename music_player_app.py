from mysql.connector import MySQLConnection
import tkinter as tk
from tkinter import ttk, messagebox
from PIL import Image, ImageTk
from pygame import mixer
import os

def authenticate(username, password):#db connection
    conn = MySQLConnection(host="localhost", user="root", password="", database="newmusic")
    cursor = conn.cursor()
    cursor.execute("select id FROM users where username=%s and password=%s", (username, password))
    user = cursor.fetchone()
    conn.close()
    return user[0] if user else None

def fetch_songs(user_id):#get all songs
    conn = MySQLConnection(host="localhost", user="root", password="", database="newmusic")
    cursor = conn.cursor()
    cursor.execute("""SELECT songs.songName, songs.artistName, songs.filePath, songs.coverImagePath FROM songs JOIN user_songs ON songs.id = user_songs.songId WHERE user_songs.userId = %s""", (user_id,))
    songs = cursor.fetchall()
    conn.close()
    return songs

class MusicPlayer:
    def __init__(self, window, user_id):
        self.window=window
        self.window.title('Music Player')
        self.window.geometry("500x500")
        self.window.configure(background='white')
        mixer.init()
        self.songs=fetch_songs(user_id)
        self.current_song_index=1

        #song photo
        self.cover_label=tk.Label(self.window, bg="white")
        self.cover_label.place(x=150, y=40, width=200, height=200)

        #song name
        self.song_label=tk.Label(self.window,text="",bg="white",font=("Arial", 12, "bold"))
        self.song_label.place(x=100, y=250, width=300)

        #dropdown
        self.selected_song=tk.StringVar()
        self.song_dropdown=ttk.Combobox(self.window, textvariable=self.selected_song, state="readonly")
        self.song_dropdown["values"]=[f"{s[0]} - {s[1]}" for s in self.songs]
        self.song_dropdown.bind("<<ComboboxSelected>>",self.load_selected_song)
        self.song_dropdown.place(x=170,y=280)

        self.play_button = tk.Button(self.window,text=" ▶ Play",command=self.play_music)
        self.play_button.place(x=220,y=320)

        self.prev_button = tk.Button(self.window,text="⏮ Previous",command=self.play_previous)
        self.prev_button.place(x=130,y=320)

        self.next_button = tk.Button(self.window, text="⏭ Next",command=self.play_next)
        self.next_button.place(x=290,y=320)

        self.scale = tk.Scale(self.window,from_=0,to=100,orient="horizontal",length=220,bg='white',command=self.adjust_volume)
        self.scale.set(50)
        self.scale.place(x=150,y=370)

        #mute-unmute button
        self.unmute_img = ImageTk.PhotoImage(Image.open("unmute.png").resize((50, 50)))
        self.mute_img = ImageTk.PhotoImage(Image.open("mute.png").resize((50, 50)))
        self.volume_button = tk.Button(self.window, image=self.unmute_img,command=self.mute,bg='white',bd=0)
        self.volume_button.place(x=100, y=370)

        if self.songs:
            self.load_song(1)

    def load_song(self, index):
        self.current_song_index = index
        song_name, artist, file_path, cover_path = self.songs[index]
        self.selected_song.set(f"{song_name}-{artist}")
        self.song_label.config(text=f"{song_name}-{artist}")
        if os.path.exists(cover_path):
            image = Image.open(cover_path).resize((200,200))
            self.cover_image = ImageTk.PhotoImage(image)
            self.cover_label.config(image=self.cover_image)
        else:
            self.cover_label.config(image="")
        self.current_song_path = file_path

    def load_selected_song(self, event):
        index = self.song_dropdown.current()
        self.load_song(index)
        self.play_music()

    def play_music(self):
        mixer.music.load(self.current_song_path)
        mixer.music.set_volume(self.scale.get()/100)
        mixer.music.play()
        self.play_button.config(text="⏸ Pause",command=self.pause_music)

    def pause_music(self):
        mixer.music.pause()
        self.play_button.config(text="▶️ Play",command=self.unpause_music)

    def unpause_music(self):
        mixer.music.unpause()
        self.play_button.config(text="⏸ Pause",command=self.pause_music)

    def play_next(self):
        if self.current_song_index < len(self.songs)-1:
            self.load_song(self.current_song_index+1)
            self.play_music()

    def play_previous(self):
        if self.current_song_index > 0:
            self.load_song(self.current_song_index-1)
            self.play_music()

    def mute(self):
        mixer.music.set_volume(0)
        self.scale.set(0)
        self.volume_button.config(image=self.mute_img,command=self.unmute)

    def unmute(self):
        volume=50
        mixer.music.set_volume(volume/100)
        self.scale.set(volume)
        self.volume_button.config(image=self.unmute_img,command=self.mute)

    def adjust_volume(self, volume):
        mixer.music.set_volume(int(volume) / 100)

class LoginPage:
    def __init__(self,window):
        self.window=window
        self.window.title('Login')
        self.window.geometry("500x500")
        label = tk.Label(window,text="Login Page",font=("Arial", 16))  # Font family and size
        label.place(x=200,y=100)


        tk.Label(window, text="Username").place(x=150, y=150)
        self.username_entry = tk.Entry(window)
        self.username_entry.place(x=250, y=150, width=120)

        tk.Label(window, text="Password").place(x=150, y=200)
        self.password_entry=tk.Entry(window, show="*")
        self.password_entry.place(x=250,y=200,width=120)

        tk.Button(window,text="Login",command=self.login).place(x=200, y=250, width=100)

    def login(self):
        username=self.username_entry.get()
        password=self.password_entry.get()
        user_id=authenticate(username, password)
        if user_id:
            self.window.destroy()
            main_app(user_id)
        else:
            messagebox.showerror("Error","Invalid credentials")

def main_app(user_id):
    root=tk.Tk()
    MusicPlayer(root, user_id)
    root.mainloop()

if __name__=="__main__":
    root=tk.Tk()
    LoginPage(root)
    root.mainloop()