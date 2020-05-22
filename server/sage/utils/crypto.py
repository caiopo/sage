import base64

from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import serialization, hashes
from cryptography.hazmat.primitives.asymmetric import padding, rsa

b64ct = 'MR3Tjd6jKrB4+mjuHNEK72XkgtUd6x2l1+C1d6GJAgycJOTPFZucG7c8hq47vOlsgTmqZK0weNukW0E/BEqv7MFxB+ZSLoZ4jYyj6S+B/USQXvZjnIjKoJHRiO6S3fMiVuzx8Nf9GVrRp/XtB+HZhuj524+iENxdiShGWgOVlVnnHDYF3Y0R1YujxsEsYlrivaLXvpKVr420JPMFUnVS6A1zrqmrOtbbv1ix6IKnqBJbmZoGYPhpeeDroi3/HwTHi3XOqwyFpFsWwv9xDW5A/QU+gDsMhysRQPJjueUfWQ6aF9GN+wrabdmanob3HGjlhdDxBFNT6p2KC/AUPFIljZDTbW0j//iw3mGP8TfJaGGSucG27GFX4tG/o6AF+P7sUHdiEYY7OV5aN//IIxNulAFRCGaNoCYcX/XJmMKZ3scQldFb1DgGP6Qx48Afrp5EkqmuKaWOsPxIfq9jKdOWLn1coTHleRIO8IDAvF/h7NJqlMYVPao7AhwdNci8MdS/l1sYVRS2aPZxavXy62qgn6xfaI888UK3QfK0UeseDoLgM5dRGqJNSHavB0LI7b5xzCYFagvis8d21cRJ9E94Um3JlnUFdvW9BU7DsMgV2ONY1ltUAdkrgr1jH669HXaGbiH5TMQF+HkMGUTk5Zc/abeoE9JxqzoQQUbcLBUz188='


class RSAKey:
    def __init__(self, private_key):
        self._pk = private_key

    @classmethod
    def generate(cls) -> 'RSAKey':
        private_key = rsa.generate_private_key(
            public_exponent=65537,
            key_size=4096,
            backend=default_backend(),
        )

        return cls(private_key)

    @classmethod
    def from_pem(cls, pem: str):
        private_key = serialization.load_pem_private_key(
            pem.encode('utf-8'),
            password=None,
            backend=default_backend(),
        )

        return cls(private_key)

    def to_private_pem(self) -> str:
        return self._pk.private_bytes(
            encoding=serialization.Encoding.PEM,
            format=serialization.PrivateFormat.TraditionalOpenSSL,
            encryption_algorithm=serialization.NoEncryption()
        ).decode('utf-8')

    def to_public_pem(self) -> str:
        public_key = self._pk.public_key()
        return public_key.public_bytes(
            encoding=serialization.Encoding.PEM,
            format=serialization.PublicFormat.SubjectPublicKeyInfo
        ).decode('utf-8')

    def decrypt(self, b64ciphertext_or_list):
        if isinstance(b64ciphertext_or_list, str):
            b64ciphertext_or_list = [b64ciphertext_or_list]

        return ''.join(
            self.decrypt_single(b64ciphertext) for b64ciphertext in b64ciphertext_or_list)

    def decrypt_single(self, b64ciphertext):
        ciphertext = base64.b64decode(b64ciphertext)

        decrypted_bytes = self._pk.decrypt(
            ciphertext,
            padding.OAEP(
                mgf=padding.MGF1(algorithm=hashes.SHA1()),
                algorithm=hashes.SHA1(),
                label=None
            ),
        )

        return decrypted_bytes.decode('utf-8')


if __name__ == '__main__':
    a = 'hvPaBp0aBwGPKhsquMnM3g+fYpDCM6tecCYIhtJDIaqFy+/TUwyIOM7u2+vwODhRqlVFwQeTD/8v+MtkvThpSfKVP3jtXidPsTYLzs+FWf4qL3EH2hyOV3z30a4vJ8nN83Nu+PAuR8l/iKXMWAZ89HkFfzZtGb5YYeahEd/4XHNf7ST8xYlvfRj4o1wp0VDG9Ot2ALvM8CywBfI9nXiLzfZUjqyQrbhKzDXaYavOtZ4KBc9FON8x9FkVHkEuD1vkfP81iLspkzSveUj+ybcTnIw4jutgnmz2ZGSvexQlPQeac3VKGIqiOcJkwa4pPNXll4OqY6ss57vYRDN5EjS52+hC1S0N9dwOX8EOIameyk0b3TwIDgLvIEOgap5MX2MoYpliyZbpQbkrZsOC86cnuoqREs7Wq/kcnQJluFlUVqZGlKTvSBuLDzU6VBdvp5gx91R4263PHmvb+FUqZTKdbJaJzI29ZaWvV7n68nwy95uBUezuRwJCIQi51Y0ky1369PTck9QV+1FmAOgIQVuPWDbnSrrvZRVh6xtljTpQuHi3lPN2Tu/CERZlm/MwzkyGp8Whn6KESz1FVkUJlmZT8dzfc/aI+cXRGuQvYyNuB8KoXNa59eGDcJi0E3e2aHQXZp6mdK4CUpwOJ/zrg1aDMQ5wP1vudN7HTSdCPTIVkYY='

    b = [
        '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',
    ]

    with open('priv.pem') as f:
        key = RSAKey.from_pem(f.read())

    dec = key.decrypt(b)

    print(dec)
