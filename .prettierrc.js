/**
 * Defaults from Prettier.
 * @see https://prettier.io/docs/en/options.html
 */
const prettierDefaults = {
  arrowParens: 'avoid',
  bracketSameLine: false,
  bracketSpacing: true,
  insertPragma: false,
  jsxSingleQuote: false,
  printWidth: 80,
  quoteProps: 'as-needed',
  rangeEnd: Infinity,
  rangeStart: 0,
  requirePragma: false,
  semi: true,
  singleQuote: false,
  tabWidth: 2,
  trailingComma: 'none',
  useTabs: false,
};

/**
 * Custom overrides.
 */
const prettierCustom = {
  printWidth: 120,
  singleQuote: true,
  trailingComma: 'es5',
};

const prettierCustomOverrides = {
  overrides: [
    {
      files: ['.eslintrc', '.babelrc'],
      options: {
        parser: 'json',
        semi: false,
        tabWidth: 2,
        trailingComma: 'none',
      },
    },
    {
      files: ['.editorconfig'],
      options: {
        parser: 'yaml',
      },
    },
  ],
};

/**
 * Prettier defaults with Custom overrides.
 */
const config = {
  ...prettierDefaults,
  ...prettierCustom,
  ...prettierCustomOverrides,
};

module.exports = config;
