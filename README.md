# Неправильные глаголы для iPhone (AltStore)

166 неправильных глаголов английского, 12 блоков, режимы: карточки, выбор формы, ввод, на слух.

## Как получить .ipa (Mac не нужен)

1. Создай пустой репозиторий на github.com (можно приватный).
2. Загрузи туда содержимое этого архива, сохранив папки `ios/` и `.github/` (кнопка "Add file" → "Upload files", перетащи всё сразу).
3. Открой вкладку **Actions** → workflow "Build IPA for AltStore" запустится сам (или нажми "Run workflow").
4. Через 3–5 минут во вкладке **Releases** появится `IrregularVerbs.ipa`.

## Установка через AltStore

1. На iPhone открой Releases в Safari и скачай `IrregularVerbs.ipa` (сохранится в "Файлы").
2. Открой AltStore → вкладка **My Apps** → **+** → выбери `IrregularVerbs.ipa`.
3. AltStore подпишет приложение твоим Apple ID и установит его.

С бесплатным Apple ID подпись живёт 7 дней — AltStore продлевает её сам, если AltServer запущен на компьютере в той же сети.

## Структура

- `ios/IrregularVerbs/index.html` — всё приложение (можно править список глаголов в `RAW`).
- `ios/IrregularVerbs/App.swift` — оболочка на SwiftUI + WKWebView, прогресс хранится в UserDefaults.
- `ios/project.yml` — описание проекта для XcodeGen.
- `.github/workflows/build-ipa.yml` — сборка неподписанного .ipa на GitHub.

На Mac можно собрать и локально: `brew install xcodegen && cd ios && xcodegen generate && open IrregularVerbs.xcodeproj`.

Если папка `.github` не загружается (на Mac/iPhone она скрытая): в репозитории открой **Actions** → **set up a workflow yourself**, вставь содержимое `build-ipa.yml` и нажми **Commit**.
