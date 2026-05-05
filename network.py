import subprocess

status = subprocess.run(["nmcli", "net"], text=True, capture_output=True)

match status.stdout.strip():
    case "enabled":
        subprocess.run(["nmcli", "net", "off"])
    case "disabled":
        subprocess.run(["nmcli", "net", "on"])
