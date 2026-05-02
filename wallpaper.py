import json
import random
import os, subprocess

SUFFIX = ("png", "jpg", "jpeg", "webp")

class Path:
    def __init__(self, path: str = "") -> None:
        if path == "":
            path = os.path.expanduser("~")

        self.path = path

    def append(self, path: str) -> None:
        new_path = os.path.join(self.path, path)
        
        if os.path.exists(new_path):
            self.path = new_path

    def pop(self) -> str:
        split = self.path.split("/")
        pop = split.pop()
        self.path: str = "/".join(split)
        return pop

    def as_str(self) -> str:
        return self.path

    def exists(self) -> bool:
        return os.path.exists(self.path)

    def list_current_dir(self) -> list[str]:
        return os.listdir(self.path)


class Wallpaper:
    def __init__(self, path: str = "") -> None:
        self.current_path: Path = Path(path)
        self.config_path = f"{os.path.expanduser('~')}/.config/hypr/config.json"
        self.data: list[str] = self.current_path.list_current_dir()
        self._read_config()

    def _read_config(self) -> None:
        if not os.path.exists(self.config_path):
            with open(self.config_path, "w") as f:
                f.write('{\n    "dir_path": "",\n    "img": ""\n}')

        with open(self.config_path, "r") as f:
            self.config = json.load(f)

    def _write_config(self) -> None:
        with open(self.config_path, "w") as f:
            json.dump(self.config, f)

    def _call_rofi(self) -> str:
        rofi = subprocess.run([
                "rofi",
                "-dmenu",
                "-p",
                "Wallpaper",
                "-theme",
                "~/.config/rofi/launchers/type-2/style-2.rasi"
            ],
            input=f"{'\n'.join(['.', '..'])}\n{'\n'.join(self.data)}",
            text=True,
            capture_output=True
        )

        return rofi.stdout.strip()

    def _set_wallpaper(self) -> None:
        print(self.current_path.as_str())
        subprocess.run([
            "awww",
            "img",
            self.current_path.as_str().strip(),
            "-t",
            "fade",
            "--transition-fps",
            "60",
            "--transition-duration",
            "1"
        ])
        subprocess.run(["awww", "clear-cache"])

        self._update_colors()

    def _set_selected_wallpaper(self) -> None:
        img_path = self.current_path.as_str()

        self.config["dir_path"] = img_path
        self._write_config()

        self._set_wallpaper()

    def _update_colors(self) -> None:
        subprocess.run(["hyprpanel", "setWallpaper", self.current_path.as_str().strip()])
        subprocess.run(["matugen", "image", self.current_path.as_str(), "--source-color-index", "0"])


    def run(self) -> None:
        while (True):
            rofi_data: str = self._call_rofi()

            match rofi_data:
                case None | "":
                    break
                case ".":
                    continue
                case "..":
                    self.current_path.pop()
                case _:
                    self.current_path.append(rofi_data)

            self.data = self.current_path.list_current_dir()

            if not self.current_path.exists():
                break

            has_image = True

            items = [
                True if item.split(".")[-1].lower() in SUFFIX
                else False
                for item in self.data
            ]

            for item in items:
                if item == False:
                    has_image = False
                    break

            if has_image:
                self._set_selected_wallpaper()
                break

    def set_random(self) -> None:
        self.current_path = Path(self.config["dir_path"])
        img = random.choice(self.current_path.list_current_dir())
        self.current_path = Path(f"{self.current_path.as_str()}/{img}")

        self.config["img"] = img
        self._write_config()

        self._set_wallpaper()

    def set_next(self) -> None:
        self.current_path = Path(self.config["dir_path"])
        img = self.config["img"]
        index = 0

        imgs = [
            file
            for file in self.current_path.list_current_dir()
            if file.split(".")[-1].lower() in SUFFIX
        ]

        if img in imgs:
            index = imgs.index(img) + 1

        if index >= len(imgs):
            index = 0

        img = imgs[index]
        self.current_path = Path(f"{self.current_path.as_str()}/{img}")

        self.config["img"] = img
        self._write_config()
        
        self._set_wallpaper()

    def reload(self) -> None:
        self.current_path = Path(f"{self.config['dir_path']}/{self.config['img']}")
        self._set_wallpaper()

    def dwu(self) -> None:
        old_files = os.listdir(f"{os.path.expanduser('~')}/.dwu")

        for file in old_files:
            os.remove(f"{os.path.expanduser('~')}/.dwu/{file}")

        subprocess.run(["dwu", "--today"])
        call = subprocess.run(["dwu", "--save"], capture_output=True)

        output = str(call.stdout.strip())
        path = Path(output[output.find('/'):-1])

        print(path.as_str())

        self.current_path = path
        self._update_colors()

if __name__ == "__main__":
    app = Wallpaper()

    if len(os.sys.argv) != 2:
        app.run()
    else:
        match os.sys.argv[1].lower():
            case "random":
                app.set_random()
            case "next":
                app.set_next()
            case "reload":
                app.reload()
            case "dwu":
                app.dwu()
            case _:
                print("invalid input")
