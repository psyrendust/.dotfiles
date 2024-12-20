module.exports = {
  branches: [
    '+([0-9])?(.{+([0-9]),x}).x',
    'main',
    'next',
    'next-major',
    { name: 'beta', prerelease: true },
    { name: 'alpha', prerelease: true },
    { name: 'semantic-release', prerelease: true },
  ],
  parserOpts: {
    noteKeywords: ['BREAKING CHANGE', 'BREAKING CHANGES', 'BREAKING'],
  },
  plugins: [
    '@semantic-release/commit-analyzer',
    '@semantic-release/release-notes-generator',
    '@semantic-release/github',
  ],
  preset: 'conventionalcommits',
};
