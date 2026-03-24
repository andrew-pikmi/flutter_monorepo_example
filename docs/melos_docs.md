## Melos: установка, развёртывание и применение

### 1. Назначение

`Melos` — инструмент для управления Flutter monorepo.

Инструмент предназначен для следующих задач:

- объединение нескольких приложений и пакетов в одном workspace;
- bootstrap и синхронизация зависимостей внутри monorepo;
- запуск команд по нескольким пакетам;
- фильтрация пакетов по различным условиям;
- versioning, changelog и release workflow.

### 2. Установка

#### 2.1. Глобальная установка

```bash
dart pub global activate melos
```

Проверка:

```bash
melos --version
```

#### 2.2. Локальный запуск

```bash
fvm dart run melos --version
```

Такой способ предпочтителен, если проект использует `FVM`.

### 3. Базовая структура monorepo

Пример структуры Flutter monorepo:

```text
apps/
  app_one/
  app_two/

packages/
  ui_kit/
  feature_a/
  feature_b/
```

Корневой `pubspec.yaml` должен содержать workspace и конфигурацию `melos`.

Пример:

```yaml
name: flutter_monorepo

environment:
  sdk: ">=3.11.0 <4.0.0"

dev_dependencies:
  melos: ^7.0.0

workspace:
  - apps/*
  - packages/*

melos:
  sdkPath: .fvm/flutter_sdk

  scripts:
    test:
      run: dart run melos exec --concurrency=1 --dir-exists="test" -- "flutter test"

    format:
      run: dart run melos exec --concurrency=1 -- "dart format --set-exit-if-changed ."

    analyze:
      run: dart run melos exec --concurrency=1 -- "flutter analyze ."
```

### 4. Развёртывание monorepo с использованием Melos

После создания корневого `pubspec.yaml` необходимо:

```bash
fvm flutter pub get
fvm dart run melos bs
```

Команда bootstrap получает зависимости и связывает пакеты в workspace.

### 5. Основные команды

#### 5.1. Список пакетов

```bash
fvm dart run melos list
```

#### 5.2. Граф зависимостей

```bash
fvm dart run melos list --graph
```

#### 5.3. Очистка workspace-артефактов

```bash
fvm dart run melos clean
```

#### 5.4. Запуск скрипта, объявленного в `melos.scripts`:

```bash
fvm dart run melos run analyze
```

### 6. Команда exec

`melos exec` используется для запуска произвольной команды по пакетам workspace.

Пример:

```bash
fvm dart run melos exec -- "flutter analyze ."
```

##### Фильтры

- `--no-private` - Исключить приватные пакеты (publish_to: none). По умолчанию они включены;
- `--published` - Отфильтровать пакеты, у которых текущая локальная версия уже существует на pub.dev;
- `--scope` - Включить только пакеты, имена которых соответствуют указанному glob-шаблону. Опцию можно указывать несколько раз;
- `--ignore` - Исключить пакеты, имена которых соответствуют указанному glob-шаблону. Опцию можно указывать несколько раз;
- `--category` - Отфильтровать пакеты по категориям, объявленным в корневом файле pubspec.yaml;
- `--diff` - Отфильтровать пакеты по наличию изменений между указанным коммитом и текущим HEAD или внутри диапазона коммитов;
- `--dir-exists` - Включить только пакеты, внутри которых существует указанная директория;
- `--file-exists` - Включить только пакеты, внутри которых существует указанный файл;
- `--flutter` - Отфильтровать пакеты, которые зависят от Flutter SDK;
- `--depends-on` - Включить только пакеты, зависящие от указанных зависимостей;
- `--include-dependencies` - Расширить отфильтрованный список пакетов, добавив все их транзитивные зависимости (игнорируя фильтры);
- `--include-dependents` - Расширить отфильтрованный список пакетов, добавив все их транзитивные зависимые пакеты (игнорируя фильтры);
- `--concurrency` - ограничить количество параллельных процессов.


##### Примеры:

Запуск только по одному пакету:

```bash
fvm dart run melos exec --scope=simple_calculator -- "flutter analyze ."
```

Запуск только по изменённым пакетам:

```bash
fvm dart run melos exec --diff=origin/master...HEAD -- "flutter analyze ."
```

Запуск по пакетам с тестами:

```bash
fvm dart run melos exec --dir-exists="test" -- "flutter test"
```

Запуск по выбранному пакету и его dependents:

```bash
fvm dart run melos exec \
  --scope=simple_calculator \
  --include-dependents \
  -- "dart format --set-exit-if-changed ."
```

Последовательный запуск с учётом графа зависимостей:

```bash
fvm dart run melos exec \
  --scope=simple_calculator \
  --include-dependents \
  --order-dependents \
  -- "flutter analyze ."
```

### 7. Versioning и релизы

`Melos` поддерживает пакетный versioning.

#### 7.1 Prerelease:

```bash
fvm dart run melos version -p --preid dev --yes
```

#### 7.2 Graduate release:

```bash
fvm dart run melos version -g --yes
```

### 8. Официальные источники

- [Melos Getting Started](https://melos.invertase.dev/getting-started)
- [Melos Commands](https://melos.invertase.dev/commands/overview)
- [Melos Filters](https://melos.invertase.dev/filters)