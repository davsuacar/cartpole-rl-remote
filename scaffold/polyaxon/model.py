from __future__ import division, print_function, absolute_import

import sys


from cartpole.client import shell_cmd as cartpole_client
from polyaxon_client.tracking import Experiment, get_outputs_path


def main(argv=sys.argv[1:]):

    # Polyaxon experiment
    experiment = Experiment()

    argv.extend(['-f', get_outputs_path()])

    cartpole_client.main(argv)

    experiment.log_metrics(score=cartpole_client.RESULTS[0]['score'])


if __name__ == '__main__':
    main(argv=sys.argv[1:])
