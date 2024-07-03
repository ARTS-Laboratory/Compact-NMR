import sys
import matplotlib.pyplot as plt

def generate_cpmg_sequence(pulse_high_time, tau, duration, output_file, plot=False):

    duration_us = int(duration * 1e6)    # duration from s to us

    # num entries for first pulse high time and tau
    first_pulse_high = pulse_high_time
    first_tau = tau
    subsequent_pulse_high = 2 * pulse_high_time
    subsequent_tau = 2 * tau

    # arbitrary buffer of 100 entries of "0.0," may need to play around with this
    buffer_zone = ["0.0"] * 100

    # first pulse and tau sequence
    first_pulse_sequence = ["1.0"] * first_pulse_high + ["0.0"] * first_tau

    # subsequent pulse and tau sequence
    subsequent_pulse_sequence = ["1.0"] * subsequent_pulse_high + ["0.0"] * subsequent_tau

    # init full sequence with the buffer
    full_sequence = buffer_zone + first_pulse_sequence

    # stitch subsequent pulse sequences until duration is met
    while len(full_sequence) < duration_us:
        full_sequence += subsequent_pulse_sequence

    # keeps sequence < duration, can probably toss this
    full_sequence = full_sequence[:duration_us]

    # sequence to output .txt
    with open(output_file, 'w') as f:
        for value in full_sequence:
            f.write(f"{value}\t")

    print(f"CPMG written to {output_file}\n Length: {len(full_sequence)}")

    #print(full_sequence[:300])

    if plot:
        plt.plot(full_sequence[:15000])
        plt.title("first few pulses")
        plt.xlabel("time (us)")
        plt.ylabel("amplitude")
        plt.show()

if __name__ == "__main__":
    if len(sys.argv) < 5 or len(sys.argv) > 6:
        print("Usage: python cpmg.py <pulse_high_time> <tau> <duration> <output_file> [plot]")
        sys.exit(1)

    pulse_high_time = int(sys.argv[1])
    tau = int(sys.argv[2])
    duration = float(sys.argv[3])
    output_file = sys.argv[4]
    plot = len(sys.argv) == 6 and sys.argv[5] == "plot"

    generate_cpmg_sequence(pulse_high_time, tau, duration, output_file, plot)
