from pathlib import Path


def print_all_files(paths):
    for p in paths:
        print(f'Arquivo: {p}\n')
        print(file_content(p))
        print()


def file_content(path):
    with path.open() as f:
        return f.read()


print('\\begin{verbatim}')
print_all_files(Path('app/lib').glob('**/*.dart'))
print_all_files(Path('server/sage').glob('**/*.py'))
print('\\end{verbatim}')
