local opt = vim.opt

-- 1. Визуал и Интерфейс (Modern & Clean)
opt.number = true -- Абсолютные номера строк
opt.relativenumber = true -- Относительные (для быстрых прыжков 10j, 5k)
opt.cursorline = true -- Подсветка текущей строки
opt.signcolumn = "yes" -- Резервируем место под иконки (чтобы код не прыгал)
opt.termguicolors = true -- 24-bit TrueColor
opt.scrolloff = 10 -- Всегда оставлять 10 строк сверху/снизу при скролле
opt.sidescrolloff = 8 -- То же самое для горизонтального скролла
opt.mouse = "a" -- Мышь разрешена (иногда удобно для ресайза сплитов)
opt.laststatus = 3 -- Global Statusline (фишка 0.10+, один статуслайн на все окна)
opt.fillchars = { eob = " " } -- Убираем тильды (~) в конце пустых буферов

-- 2. Поведение и Скорость (Performance)
opt.updatetime = 200 -- Быстрее срабатывают события (например, подсветка слова)
opt.timeoutlen = 300 -- Время ожидания комбинации клавиш
opt.ttimeoutlen = 0 -- Мгновенный выход из режимов
opt.undofile = true -- Сохранять историю изменений между перезапусками
opt.confirm = true -- Спрашивать перед выходом, если есть несохраненные файлы

-- 3. Табы и Индентация (Fullstack Standard)
opt.tabstop = 2 -- Размер таба — 2 пробела (стандарт JS/TS)
opt.shiftwidth = 2 -- Размер отступа
opt.expandtab = true -- Превращать табы в пробелы
opt.smartindent = true -- Умные отступы для кода
opt.breakindent = true -- Перенос строки сохраняет отступ

-- 4. Поиск (Smart & Fast)
opt.ignorecase = true -- Игнорировать регистр при поиске
opt.smartcase = true -- Но учитывать его, если ввел заглавную букву
opt.hlsearch = false -- Не оставлять желтые пятна после поиска (сбрасываем)
opt.inccommand = "split" -- Превью замены (:%s) в отдельном окошке снизу

-- 5. Системные и Скрытые (Hidden Power)
opt.completeopt = "menu,menuone,noselect" -- Настройка выпадающего меню (для Blink)
opt.pumheight = 10 -- Макс. высота меню автодополнения (чтобы не перекрывало пол-экрана)
opt.virtualedit = "block" -- Позволяет ставить курсор за пределы строки в Visual Block режиме

-- 6. Фильтры для Telescope / :find (Игнорируем мусор)
opt.wildignore:append({
	"**/node_modules/**",
	"**/.git/**",
	"**/dist/**",
	"**/build/**",
	"**/.next/**",
})

-- 7. Кастомная отрисовка (0.12 Nightly)
-- Умный перенос строк (не режет слова)
opt.linebreak = true
opt.showbreak = "↳ "
