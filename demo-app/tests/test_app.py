import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from app import app


def test_index():
    client = app.test_client()
    res = client.get("/")

    assert res.status_code == 200
    assert res.json["status"] == "ok"
