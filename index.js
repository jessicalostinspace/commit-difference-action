const core = require('@actions/core');
const exec = require('@actions/exec');

const src = __dirname;

try {
  const baseBranch = core.getInput('base-branch');
  const secondaryBranch = core.getInput('secondary-branch');

  const regexp = /^[\.A-Za-z0-9_-]*$/;

  console.log(`base-branch: ${baseBranch}`);
  console.log(`secondary-branch: ${secondaryBranch}`);

  if (regexp.test(baseBranch) && regexp.test(secondaryBranch)) {
    getCommitDifference(baseBranch, secondaryBranch);
  } else {
    const regexError = "Branch names must contain only numbers, strings, underscores, periods, and dashes.";
    core.setFailed(regexError);
  }

} catch (error) {
  core.setFailed(error.message);
}

async function getCommitDifference(baseBranch, secondaryBranch) {
  try {
    let output = '';
    let err = '';

    // These are option configurations for the @actions/exec lib`
    const options = {};
    options.listeners = {
      stdout: (data) => {
        output += data.toString();
      },
      stderr: (data) => {
        err += data.toString();
      }
    };
    options.cwd = './';

    await exec.exec(`${src}/commit-diff-count.sh`, [baseBranch, secondaryBranch], options);
    const { commitDiffCount } = JSON.parse(output);

    console.log('Adding test log');
    if (commitDiffCount) {
      console.log('\x1b[32m%s\x1b[0m', `Difference in commits between ${secondaryBranch} and ${baseBranch}: ${commitDiffCount}`);
      core.setOutput("commit-difference-count", commitDiffCount);
    } else {
      core.setFailed(err);
      process.exit(1);
    }
  } catch (err) {
    core.setFailed(`Could not get commit difference between branches because: ${err.message}`);
    process.exit(0);
  }
}