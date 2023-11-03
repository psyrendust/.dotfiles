#!/usr/bin/env node
/**
 * Open vscode with arguments. If argument path is a directory, attempt to
 * find *.code-workspace files and prompt user if they would like to open
 * the workspace.
 */
'use strict';
import meow from 'meow';
import * as changeCase from 'change-case';

const options = new Set([
  'camelCase',
  'constantCase',
  'pascalCase',
  'lowerCase',
  'paramCase',
  'titleCase',
  'capitalCase',
  'dotCase',
  'headerCase',
  'lowerCaseFirst',
  'noCase',
  'pathCase',
  'sentenceCase',
  'snakeCase',
  'spongeCase',
  'swapCase',
  'upperCase',
  'upperCaseFirst',
]);

export function cli(args) {
  const meowCli = meow(`
    Usage
      $ changecase [option] [input]

    Options
      camelCase       Transform into a string with the separator denoted by the next word capitalized
      constantCase    Transform into upper case string with an underscore between words
      pascalCase      Transform into a string of capitalized words without separators
      lowerCase       Transforms the string to lower case
      paramCase       Transform into a lower cased string with dashes between words
      titleCase       Transform a string into title case following English rules
      capitalCase     Transform into a space separated string with each word capitalized
      dotCase         Transform into a lower case string with a period between words
      headerCase      Transform into a dash separated string of capitalized words
      lowerCaseFirst  Transforms the string with the first character in lower cased
      noCase          Transform into a lower cased string with spaces between words
      pathCase        Transform into a lower case string with slashes between words
      sentenceCase    Transform into a lower case with spaces between words then capitalize the string
      snakeCase       Transform into a lower case string with underscores between words
      spongeCase      Transform into a string with random capitalization applied
      swapCase        Transform a string by swapping every character from upper to lower case or lower to upper case
      upperCase       Transforms the string to upper case
      upperCaseFirst  Transforms the string with the first character in upper cased

    Examples
      $ changecase snake_case_string
      snakeCaseString
  `, {
    argv: args.slice(2),
    flags: {
      help: {type: 'boolean', alias: 'h'},
      version: {type: 'boolean', alias: 'v'},
    }
  });

  if (meowCli.flags.help) {
    meowCli.showHelp();
    return;
  }
  if (meowCli.flags.version) {
    meowCli.showVersion();
    return;
  }

  const [arg1, arg2] = meowCli.input;
  let option = 'camelCase';
  let input = '';

  if (arg2 != null && options.has(arg1)) {
    option = arg1;
    input = arg2;
  } else {
    input = arg1;
  }

  if (input.length > 0) {
    console.log(changeCase[option](input));
  }
}
