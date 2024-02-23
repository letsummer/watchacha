# watchacha

link: https://letsummer.github.io/watchacha/

## gh-pages 배포 자동화 방법

**출처: https://velog.io/@moseoridev/Flutter-%EC%95%B1-GitHub-Pages%EC%97%90-%EB%B0%B0%ED%8F%AC%ED%95%B4%EB%B3%B4%EC%9E%90**

**/.github/workflows** 에 **workflow.yml** 생성.
```
name: gh-pages

on:
  push:
    branches: [your-branch]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v1
      - uses: bluefireteam/flutter-gh-pages@v7
        with:
          baseHref: /your-repo-name/
```


|  | 변수 | 수정사항 |
| --- | --- | --- |
| 1 | `your-branch` | `main` 또는 `master`. 현재 `main`이 기본 최상위 branch. |
| 2 | `your-repo-name` | 자동화를 할 repository명. |

작업을 완료하면

***해당 repository - settings - pages*** 에서 ghpage 경로 설정.


> [!WARNING]
> workflow build fail 에서 403 에러가 나는 경우
> 
> ***해당 Repository - Settings - Actions - General*** 에서 ***Workflow permissions*** 을
>
> **Read and write permissions**로 변경.
> 
> 참고 링크: https://github.com/ad-m/github-push-action/issues/96#issuecomment-1647904286
