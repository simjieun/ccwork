export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'subject-empty': [2, 'never'],
    'body-min-lines': [2, 'always', 2],
  },
  plugins: [
    {
      rules: {
        'body-min-lines': ({ body }, when, minLines) => {
          if (when === 'never') return [true];
          const lines = (body || '').split('\n').filter((l) => l.trim() !== '');
          return [
            lines.length >= minLines,
            `body must have at least ${minLines} non-empty lines (current: ${lines.length})`,
          ];
        },
      },
    },
  ],
};
